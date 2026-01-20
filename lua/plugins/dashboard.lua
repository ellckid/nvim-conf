return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  config = function()
    local function get_russian_day()
      local days = {
        "Воскресенье",
        "Понедельник",
        "Вторник",
        "Среда",
        "Четверг",
        "Пятница",
        "Суббота",
      }
      local day_num = tonumber(os.date "%w")
      local day_name = days[day_num + 1]
      local date_str = os.date "%d.%m.%Y"
      return day_name .. ", " .. date_str
    end

    require("dashboard").setup {
      theme = "hyper",
      config = {
        header = {
          "",
          "  Добро пожаловать в Neovim!",
          "",
          "  " .. get_russian_day(),
          "",
        },
        shortcut = {},
      },
    }
  end,
  dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
