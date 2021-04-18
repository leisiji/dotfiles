
vim.g.mapleader = " "

-- load global options
local global_cfg = {
	hidden = true;
	backup = false;
	writebackup = false;
	autoread = true;
	autowrite = true;
	smarttab = true;
	smartindent = true;
	scrolloff = 10;
	undofile = true;
	incsearch = true;
	ignorecase = true;
	smartcase = true;
	t_Co = "256";
	termguicolors = true;
	laststatus = 2;
	showtabline = 2;
	updatetime = 500;
	shortmess = "aoOTIcF"
}
for k, v in pairs(global_cfg) do
	vim.o[k] = v
end

local win_cfg = {
	signcolumn = "yes";
	number = true;
}
for k, v in pairs(win_cfg) do
	vim.wo[k] = v
end
