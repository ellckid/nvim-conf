return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      ensure_installed = { "lua", "typescript", "javascript", "tsx", "json" },
      highlight = { enable = true },
      indent = { enable = true },
    },
  },
}
