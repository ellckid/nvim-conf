-- Прочие плагины: leap, fugitive, flog + доп. темы для переключения.
---@type LazySpec
return {
  -- Прыжки по тексту
  {
    "https://codeberg.org/andyg/leap.nvim",
    lazy = false,
    config = function()
      require("leap").add_default_mappings(true)
    end,
  },
  -- Git
  { "tpope/vim-fugitive",    cmd = { "G", "Git", "Gdiffsplit", "Gread", "Gwrite", "Gedit", "Gblame" } },
  {
    "rbong/vim-flog",
    lazy = true,
    cmd = { "Flog", "Flogsplit", "Floggit" },
    dependencies = { "tpope/vim-fugitive" },
  },
  -- Старая тема, доступна для переключения (:colorscheme seoul256)
  { "junegunn/seoul256.vim", lazy = true },
}
