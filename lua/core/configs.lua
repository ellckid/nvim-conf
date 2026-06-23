-- Line Numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- Mouse
vim.opt.mouse = "a"
vim.opt.mousefocus = true

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Indent Settings
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

-- Other
vim.opt.ttimeoutlen = 0
vim.opt.scrolloff = 8
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.undofile = true  -- persistent undo across sessions
vim.opt.splitkeep = "screen"  -- keep text stable when splitting (0.9+)

-- Treesitter-based folding (0.10+)
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99  -- start with all folds open
vim.opt.foldlevelstart = 99

-- Autosave on buffer leave
vim.api.nvim_create_autocmd("BufLeave", {
  callback = function()
    if vim.bo.modified and vim.bo.buftype == "" and vim.fn.expand "%:t" ~= "" then
      vim.cmd "silent! write"
    end
  end,
})

-- Fillchars
vim.opt.fillchars = {
  vert = "│",
  fold = "⠀",
  eob = " ",
  msgsep = "‾",
  foldopen = "▾",
  foldsep = "│",
  foldclose = "▸",
}


