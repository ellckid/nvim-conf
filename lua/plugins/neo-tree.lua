-- Neo-tree: ширина боковой панели = треть экрана.
---@type LazySpec
return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = function(_, opts)
    opts.window = opts.window or {}
    opts.window.width = math.floor(vim.o.columns / 3)
    return opts
  end,
}
