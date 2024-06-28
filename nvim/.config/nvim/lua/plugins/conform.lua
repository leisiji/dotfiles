local M = {}

function M.config()
    local conform = require("conform")
    conform.setup({
        formatters = {
            cwd = require("conform.util").root_file({ "stylua.toml", "package.json", ".clang-format" }),
        },
        injected = {
            options = {
                ignore_errors = true,
                lang_to_formatters = {
                    json = { "jq" },
                    c = { "clang_format" }
                },
            },
        },
    })
end

return M
