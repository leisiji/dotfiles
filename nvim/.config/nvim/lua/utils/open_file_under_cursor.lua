-- ============================================================================
-- open the file name under the cursor (bound to <CR>)
-- usage: require("utils.open_file_under_cursor").open()
-- <CR>: open the file name under the cursor
-- ----------------------------------------------------------------------------
-- priority:
--   1. absolute path (starts with / or ~) -> open directly in a new tab
--   2. path that already exists relative to the current dir / project root
--   3. search the filename under the project root with `fd --hidden <name>`
-- For terminal buffers the base dir is the *shell's* cwd (read from
-- /proc/<pid>/cwd), so `cd` inside the terminal is honored.
-- ============================================================================

local M = {}

local ROOT_MARKERS = {
  ".git",
  ".hg",
  ".svn",
  ".bzr",
  "_darcs",
  ".fslckout",
  ".gitignore",
  "package.json",
  "pyproject.toml",
  "Cargo.toml",
  "go.mod",
  "pom.xml",
  "build.gradle",
  "settings.gradle",
  "CMakeLists.txt",
  "composer.json",
  "Gemfile",
  "mix.exs",
  "flake.nix",
}

-- nearest ancestor of `dir` that contains a root marker
local function find_project_root(dir)
  local d = vim.fn.fnamemodify(dir, ":p")
  while true do
    for _, marker in ipairs(ROOT_MARKERS) do
      local p = d .. "/" .. marker
      if vim.fn.filereadable(p) == 1 or vim.fn.isdirectory(p) == 1 then
        return d
      end
    end
    local parent = vim.fn.fnamemodify(d, ":h")
    if parent == d then
      return nil
    end
    d = parent
  end
end

-- working directory of the shell running inside a terminal buffer
local function terminal_cwd(bufnr)
  if vim.bo[bufnr].buftype ~= "terminal" then
    return nil
  end
  local ok, job_id = pcall(vim.api.nvim_buf_get_var, bufnr, "terminal_job_id")
  if not ok then
    return nil
  end
  local ok_pid, pid = pcall(vim.fn.jobpid, job_id)
  if not ok_pid or pid <= 0 then
    return nil
  end
  if vim.uv.os_uname().sysname == "Linux" then
    local out = vim.fn.system({ "readlink", "/proc/" .. pid .. "/cwd" })
    if vim.v.shell_error == 0 then
      local cwd = vim.trim(out)
      if cwd ~= "" then
        return cwd
      end
    end
  elseif vim.fn.executable("lsof") == 1 then
    -- macOS / BSD
    local lines = vim.fn.systemlist({ "lsof", "-a", "-p", tostring(pid), "-d", "cwd", "-Fn" })
    for _, line in ipairs(lines) do
      if line:sub(1, 1) == "n" then
        return line:sub(2)
      end
    end
  end
  return nil
end

-- "path[:line[:col]]" -> path, line, col
local function split_file_and_position(s)
  local f, l, c = s:match("^(.*):(%d+):(%d+)$")
  if not f then
    f, l = s:match("^(.*):(%d+)$")
  end
  if f and f ~= "" then
    return f, tonumber(l), c and tonumber(c)
  end
  return s
end

-- number of leading path components `path` shares with `base`
local function path_closeness(path, base)
  local a = vim.split(vim.fs.dirname(path), "/")
  local b = vim.split(base, "/")
  local n = 0
  for i = 1, math.min(#a, #b) do
    if a[i] ~= b[i] then
      break
    end
    n = n + 1
  end
  return n
end

local function fd_find(name, base_dir, root)
  local results = vim.fn.systemlist({
    "fd",
    "--hidden",
    "--type",
    "f",
    "--fixed-strings",
    "--max-results",
    "100",
    name,
    root,
  })
  if #results == 0 then
    return nil
  end
  -- prefer the result closest to the current buffer / shell cwd
  table.sort(results, function(x, y)
    return path_closeness(x, base_dir) > path_closeness(y, base_dir)
  end)
  return results[1]
end

-- open `path` in a tab; jump to its window if it is already visible
local function tab_open(path, lnum, cnum)
  if vim.startswith(path, "~") or vim.startswith(path, "$") then
    path = vim.fn.expand(path) -- expand ~ and $VAR
  end
  local existing = vim.fn.bufnr(path)
  if existing ~= -1 then
    local wins = vim.fn.win_findbuf(existing)
    if #wins > 0 then
      vim.api.nvim_set_current_win(wins[1])
      if lnum then
        pcall(vim.api.nvim_win_set_cursor, 0, { lnum, (cnum or 1) - 1 })
      end
      return
    end
    -- show the hidden buffer in a new tab without duplicating it
    vim.cmd("tab split")
    vim.cmd("buffer " .. existing)
  else
    vim.cmd("tabnew " .. vim.fn.fnameescape(path))
  end
  if lnum then
    pcall(vim.api.nvim_win_set_cursor, 0, { lnum, (cnum or 1) - 1 })
  end
end

function M.open()
  local bufnr = vim.api.nvim_get_current_buf()
  local buftype = vim.bo[bufnr].buftype

  -- only real files and terminals get the fd based search; for other
  -- buffers (quickfix, help, ...) keep the previous <C-w>gF behavior
  local base_dir
  if buftype == "terminal" then
    base_dir = terminal_cwd(bufnr)
    if not base_dir then
      return
    end
  elseif buftype == "" then
    local path = vim.fn.expand("%:p")
    if path == "" then
      return
    end
    base_dir = vim.fn.fnamemodify(path, ":h")
  else
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>gF", true, false, true), "n", false)
    return
  end

  local word = vim.fn.expand("<cfile>")
  if word == "" then
    return
  end
  -- `KEY=value` assignments (e.g. PROJECT_DEFCONFIG=...): keep only the value
  -- part after the first `=`. Skip when the prefix looks like a path (contains
  -- `/`), so real filenames that happen to contain `=` are left untouched.
  local eq = word:find("=", 1, true)
  if eq and not word:sub(1, eq - 1):find("/", 1, true) then
    word = word:sub(eq + 1)
  end
  word = word:gsub("[,;)%]'\"%[%]]+$", "") -- drop trailing punctuation
  if word == "" then
    return
  end
  local fname, lnum, cnum = split_file_and_position(word)

  -- absolute path: open directly, no search
  if vim.startswith(fname, "/") or vim.startswith(fname, "~") then
    tab_open(fname, lnum, cnum)
    return
  end

  local root = find_project_root(base_dir) or base_dir

  -- relative path that already exists (like gf)
  for _, dir in ipairs({ base_dir, root }) do
    local candidate = dir .. "/" .. fname
    if vim.fn.filereadable(candidate) == 1 then
      tab_open(candidate, lnum, cnum)
      return
    end
  end

  -- otherwise search the whole project root with fd
  local found = fd_find(vim.fs.basename(fname), base_dir, root)
  if found then
    tab_open(found, lnum, cnum)
    return
  end

  vim.notify(string.format("[<CR>] not found: %s (searched in %s)", fname, root), vim.log.levels.WARN)
end

return M
