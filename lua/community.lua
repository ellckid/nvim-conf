-- AstroCommunity: подключай готовые модули сообщества тут.
-- Грузится до папки plugins/, поэтому твои plugins/* могут переопределять.
---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.note-taking.global-note-nvim" },
  -- Trouble: список диагностики снизу с навигацией (<Leader>x…)
  { import = "astrocommunity.diagnostics.trouble-nvim" },
  -- примеры (раскомментируй при желании):
  -- { import = "astrocommunity.pack.typescript" },
  -- { import = "astrocommunity.pack.go" },
  -- { import = "astrocommunity.pack.lua" },
  -- { import = "astrocommunity.debugging.nvim-dap" }, -- если снова нужен DAP на v5
}
