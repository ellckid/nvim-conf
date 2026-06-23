return {
  "mg979/vim-visual-multi",
  branch = "master",
  event = "VeryLazy",
  config = function()
    -- opt+n в визуальном режиме → курсор на начало каждой строки
    vim.keymap.set("x", "<M-n>", "<Plug>(VM-Visual-Cursors)", { silent = true })
  end,
}
