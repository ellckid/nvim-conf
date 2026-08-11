-- Telescope: биндинги вынесены в astrocore. Тут отключение treesitter-превью
-- (фикс ошибки ft_to_lang) + ui-select под курсором (для code action и т.п.).
---@type LazySpec
return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-telescope/telescope-ui-select.nvim" },
  opts = function(_, opts)
    opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
      preview = { treesitter = false },
    })
    opts.extensions = vim.tbl_deep_extend("force", opts.extensions or {}, {
      ["ui-select"] = require("telescope.themes").get_cursor {},
    })
    return opts
  end,
  config = function(_, opts)
    local telescope = require "telescope"
    telescope.setup(opts)
    telescope.load_extension "ui-select"
  end,
}
