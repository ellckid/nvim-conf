-- Trouble: диагностика списком СНИЗУ с навигацией (j/k + Enter — прыжок к месту).
---@type LazySpec
return {
  "folke/trouble.nvim",
  opts = {
    focus = true, -- сразу переводить фокус в список
    modes = {
      diagnostics = {
        win = { position = "bottom", size = 0.3 },
      },
    },
  },
}
