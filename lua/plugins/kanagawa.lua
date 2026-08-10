-- Kanagawa: тема + контрастные менюшки/флоаты, чтобы всё было читаемо.
---@type LazySpec
return {
  "rebelot/kanagawa.nvim",
  opts = {
    theme = "dragon",
    -- Меню автодополнения и плавающие окна с явным фоном/рамкой.
    overrides = function(colors)
      local theme = colors.theme
      local pal = colors.palette
      -- Флоаты СВЕТЛЕЕ редактора + яркая рамка → чётко видны на тёмном фоне.
      return {
        NormalFloat = { fg = theme.ui.fg, bg = theme.ui.bg_p1 },
        FloatBorder = { fg = pal.dragonBlue2, bg = theme.ui.bg_p1 },
        FloatTitle = { fg = pal.dragonYellow, bg = theme.ui.bg_p1, bold = true },
        LazyNormal = { bg = theme.ui.bg_p1, fg = theme.ui.fg },
        MasonNormal = { bg = theme.ui.bg_p1, fg = theme.ui.fg },
        -- Popup-меню автодополнения: заметный фон, контрастное выделение
        Pmenu = { fg = theme.ui.fg, bg = theme.ui.bg_p1 },
        PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2, bold = true },
        PmenuSbar = { bg = theme.ui.bg_m1 },
        PmenuThumb = { bg = theme.ui.bg_p2 },
      }
    end,
  },
}
