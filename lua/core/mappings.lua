-- Leader
vim.g.mapleader = " "

-- Insert
vim.keymap.set("i", "jk", "<Esc>")

-- Neo-tree
vim.keymap.set("n", "<c-n>", ":Neotree left toggle reveal<CR>")

-- Navigation
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

-- Splits
vim.keymap.set("n", "|", ":vsplit<CR>")
vim.keymap.set("n", "\\", ":split<CR>")

-- Tabs
vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>")
vim.keymap.set("n", "<s-Tab>", ":BufferLineCyclePrev<CR>")
vim.keymap.set("n", "<leader>x", ":BufferLinePickClose<CR>")
vim.keymap.set("n", "<c-x>", ":BufferLineCloseOthers<CR>")
vim.keymap.set("n", "<leader>tp", ":BufferLineTogglePin <CR>")

vim.keymap.set("n", "H", "^")
vim.keymap.set("n", "L", "$")
vim.keymap.set("v", "H", "^")
vim.keymap.set("v", "L", "$")

vim.keymap.set("n", ",,", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
vim.keymap.set("n", "..", "<cmd>lua vim.diagnostic.goto_next()<CR>")
