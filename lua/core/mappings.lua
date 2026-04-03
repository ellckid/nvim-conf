-- Leader
vim.g.mapleader = " "

-- Insert
vim.keymap.set("i", "jk", "<Esc>")

-- Completion (встроенный popup)
vim.keymap.set("i", "<Tab>", function()
  return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>"
end, { expr = true })
vim.keymap.set("i", "<S-Tab>", function()
  return vim.fn.pumvisible() == 1 and "<C-p>" or "<S-Tab>"
end, { expr = true })
vim.keymap.set("i", "<CR>", function()
  return vim.fn.pumvisible() == 1 and "<C-y>" or "<CR>"
end, { expr = true })

-- Neo-tree
vim.keymap.set("n", "<c-n>", ":Neotree left toggle reveal<CR>")

-- Window navigation
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

-- Splits
vim.keymap.set("n", "|", ":vsplit<CR>")
vim.keymap.set("n", "\\", ":split<CR>")

-- Buffers (вместо bufferline)
vim.keymap.set("n", "<Tab>", ":bnext<CR>")
vim.keymap.set("n", "<s-Tab>", ":bprev<CR>")
vim.keymap.set("n", "<leader>x", ":bdelete<CR>")
vim.keymap.set("n", "<c-x>", function()
  local current = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current and vim.bo[buf].buflisted then
      vim.api.nvim_buf_delete(buf, {})
    end
  end
end)

-- Motion
vim.keymap.set("n", "H", "^")
vim.keymap.set("n", "L", "$")
vim.keymap.set("v", "H", "^")
vim.keymap.set("v", "L", "$")

-- Diagnostics
vim.keymap.set("n", ",,", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
vim.keymap.set("n", "..", "<cmd>lua vim.diagnostic.goto_next()<CR>")

-- Terminal (вместо toggleterm)
vim.keymap.set("n", [[<c-\>]], ":split | terminal<CR>")
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
