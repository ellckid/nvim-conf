-- Neo-tree: ширина 40%, автофокус на текущем файле (иконки — astro/nerd font).
---@type LazySpec
return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = function(_, opts)
    opts.close_if_last_window = false
    opts.window = vim.tbl_deep_extend("force", opts.window or {}, {
      width = math.floor(vim.o.columns * 0.4),
      position = "left",
    })
    opts.filesystem = vim.tbl_deep_extend("force", opts.filesystem or {}, {
      follow_current_file = { enabled = true, leave_dirs_open = false },
    })
    return opts
  end,
}
