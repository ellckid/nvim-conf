-- Treesitter: список парсеров для автоустановки.
-- Сам плагин идёт из ядра AstroNvim v5, тут только доустановка языков.
---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
      "bash",
      "css",
      "html",
      "javascript",
      "json",
      "jsonc",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "query",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
    })
  end,
}
