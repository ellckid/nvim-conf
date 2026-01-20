return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("telescope").setup {}
    local builtin = require "telescope.builtin"
    vim.keymap.set("n", "<leader>ff", function()
      builtin.find_files { hidden = true }
    end)
    vim.keymap.set("n", "<leader>fw", builtin.live_grep, {})
    vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
    vim.keymap.set("n", "<leader>fg", builtin.git_status, { desc = "Git Changed Files" })
  end,
}
