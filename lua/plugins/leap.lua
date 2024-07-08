return {
  "ggandor/leap.nvim",
  branch = "main",
  init = function ()
    require('leap').add_default_mappings()
  end,
  dependencies = {
    "tpope/vim-repeat"
  }
}
