-- Aerial: outline-символы. Treesitter-бэкенд падает на nvim 0.12
-- (query:iter_matches убрал опцию all=false → capture теперь список нод,
--  а aerial 2.7.0 зовёт node:start() на таблице). Отключаем ts-бэкенд,
--  LSP покрывает lua/ts. Вернуть "treesitter" когда aerial починят.
---@type LazySpec
return {
  "stevearc/aerial.nvim",
  opts = {
    backends = { "lsp", "markdown", "man" },
  },
}
