-- none-ls: форматтеры (stylua/prettier) и линтер luacheck.
-- Заменяет твои conform.nvim + nvim-lint. Format-on-save включён в astrolsp.
-- eslint-диагностика идёт через eslint LSP-сервер.
---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  opts = function(_, config)
    local null_ls = require "null-ls"
    config.sources = {
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.prettier.with {
        filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "css", "scss" },
      },
      null_ls.builtins.diagnostics.luacheck,
    }
    return config
  end,
}
