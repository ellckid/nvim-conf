-- Leader
vim.g.mapleader = " "

-- Insert
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })

-- Completion (встроенный popup)
vim.keymap.set("i", "<Tab>", function()
  return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>"
end, { expr = true, desc = "Next completion / Tab" })
vim.keymap.set("i", "<S-Tab>", function()
  return vim.fn.pumvisible() == 1 and "<C-p>" or "<S-Tab>"
end, { expr = true, desc = "Prev completion / S-Tab" })
vim.keymap.set("i", "<CR>", function()
  return vim.fn.pumvisible() == 1 and "<C-y>" or "<CR>"
end, { expr = true, desc = "Confirm completion / Enter" })

-- Neo-tree
vim.keymap.set("n", "<c-n>", ":Neotree left toggle reveal<CR>", { desc = "Toggle file tree" })

-- Window navigation
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>", { desc = "Window up" })
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>", { desc = "Window down" })
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>", { desc = "Window left" })
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>", { desc = "Window right" })

-- Splits
vim.keymap.set("n", "|", ":vsplit<CR>", { desc = "Vertical split" })
vim.keymap.set("n", "\\", ":split<CR>", { desc = "Horizontal split" })

-- Buffers
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<s-Tab>", ":bprev<CR>", { desc = "Prev buffer" })
vim.keymap.set("n", "<leader>x", ":bdelete<CR>", { desc = "Close buffer" })
vim.keymap.set("n", "<c-x>", function()
  local current = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current and vim.bo[buf].buflisted then
      vim.api.nvim_buf_delete(buf, {})
    end
  end
end, { desc = "Close all other buffers" })

-- Motion
vim.keymap.set({ "n", "v" }, "H", "^", { desc = "Start of line" })
vim.keymap.set({ "n", "v" }, "L", "$", { desc = "End of line" })

-- Format operator (like Q gq in IdeaVim)
vim.keymap.set("n", "Q", "gq", { desc = "Format motion" })

-- Stay at selection after yank
vim.keymap.set("v", "y", "ygv<Esc>", { desc = "Yank without losing selection" })

-- Paste without overwriting yank register
vim.keymap.set("v", "p", "p:let @+=@0<CR>:let @\"=@0<CR>", { silent = true, desc = "Paste, keep yank register" })

-- Search for visually selected text
vim.keymap.set("v", "n", "y/<C-R>\"<CR>", { silent = true, desc = "Search selected text" })

-- Diagnostics
vim.keymap.set("n", ",,", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
vim.keymap.set("n", "..", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic float" })

-- Replace in file
vim.keymap.set("n", "<Leader>rp", ":%s/", { silent = false, desc = "Replace in file" })
vim.keymap.set("v", "<Leader>rp", ":s/", { silent = false, desc = "Replace in selection" })

-- Git diff (fugitive)
vim.keymap.set("n", "<Leader>gg", ":Gdiffsplit<CR>", { silent = true, desc = "Git diff split" })
vim.keymap.set("n", "<Leader>ge", ":diffoff | only<CR>", { silent = true, desc = "Close diff" })

-- Close split
vim.keymap.set("n", "<C-BS>", ":close<CR>", { silent = true, desc = "Close split" })

-- Terminal
vim.keymap.set("n", [[<c-\>]], ":split | terminal<CR>", { desc = "Open terminal split" })
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    local opts = { buffer = 0 }
    vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
    vim.keymap.set("t", "jj", [[<C-\><C-n>]], opts)
    vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.cmd "startinsert"
  end,
})
