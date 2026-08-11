-- AstroCore: опции, маппинги, автокоманды.
---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    features = {
      large_buf = { size = 1024 * 500, lines = 10000 },
      autopairs = true,
      cmp = true,
      diagnostics = { virtual_text = true, virtual_lines = false },
      highlighturl = true,
      notifications = true,
    },
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    options = {
      opt = {
        number = true,
        relativenumber = true,
        mouse = "a",
        mousefocus = true,
        clipboard = "unnamedplus",
        shiftwidth = 4,
        tabstop = 4,
        softtabstop = 4,
        scrolloff = 8,
        wrap = false,
        termguicolors = true,
        signcolumn = "yes",
        fillchars = {
          vert = "│",
          fold = "⠀",
          eob = " ",
          msgsep = "‾",
          foldopen = "▾",
          foldsep = "│",
          foldclose = "▸",
        },
      },
      g = {},
    },
    mappings = {
      n = {
        -- Neo-tree
        ["<C-n>"] = { "<Cmd>Neotree left toggle reveal<CR>", desc = "Toggle Neo-tree" },
        -- Навигация по окнам
        ["<C-k>"] = { "<Cmd>wincmd k<CR>", desc = "Окно вверх" },
        ["<C-j>"] = { "<Cmd>wincmd j<CR>", desc = "Окно вниз" },
        ["<C-h>"] = { "<Cmd>wincmd h<CR>", desc = "Окно влево" },
        ["<C-l>"] = { "<Cmd>wincmd l<CR>", desc = "Окно вправо" },
        -- Сплиты
        ["|"] = { "<Cmd>vsplit<CR>", desc = "Вертикальный сплит" },
        ["\\"] = { "<Cmd>split<CR>", desc = "Горизонтальный сплит" },
        -- Буферы
        ["<Tab>"] = { "<Cmd>bnext<CR>", desc = "Следующий буфер" },
        ["<S-Tab>"] = { "<Cmd>bprevious<CR>", desc = "Предыдущий буфер" },
        ["<Leader>x"] = { "<Cmd>bdelete<CR>", desc = "Закрыть буфер" },
        ["<C-x>"] = {
          function()
            local current = vim.api.nvim_get_current_buf()
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
              if buf ~= current and vim.bo[buf].buflisted then vim.api.nvim_buf_delete(buf, {}) end
            end
          end,
          desc = "Закрыть остальные буферы",
        },
        -- Движение
        ["H"] = { "^", desc = "Начало строки" },
        ["L"] = { "$", desc = "Конец строки" },
        -- Диагностика
        [",,"] = {
          function() vim.diagnostic.jump { count = -1, float = true } end,
          desc = "Пред. диагностика",
        },
        [".."] = {
          function() vim.diagnostic.jump { count = 1, float = true } end,
          desc = "След. диагностика",
        },
        -- Терминал
        ["<C-\\>"] = { "<Cmd>split | terminal<CR>", desc = "Терминал" },
        -- Which-key для буфера
        ["<Leader>?"] = {
          function() require("which-key").show { global = false } end,
          desc = "Локальные биндинги буфера",
        },
        -- Telescope
        ["<Leader>ff"] = {
          function() require("telescope.builtin").find_files { hidden = true } end,
          desc = "Найти файлы (со скрытыми)",
        },
        ["<Leader>fw"] = { function() require("telescope.builtin").live_grep() end, desc = "Live grep" },
        ["<Leader>fb"] = { function() require("telescope.builtin").buffers() end, desc = "Буферы" },
        ["<Leader>fg"] = {
          function() require("telescope.builtin").git_status() end,
          desc = "Git изменённые файлы",
        },
      },
      v = {
        ["H"] = { "^", desc = "Начало строки" },
        ["L"] = { "$", desc = "Конец строки" },
      },
      i = {
        ["jk"] = { "<Esc>", desc = "Escape" },
      },
    },
    autocmds = {
      -- Автооткрытие neo-tree при старте
      neotree_start = {
        {
          event = "VimEnter",
          desc = "Открыть Neo-tree при запуске",
          callback = function() vim.cmd "Neotree left show" end,
        },
      },
      -- Настройки терминала
      term_settings = {
        {
          event = "TermOpen",
          desc = "Биндинги и опции терминала",
          callback = function()
            local opts = { buffer = 0 }
            vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], opts)
            vim.keymap.set("t", "jj", [[<C-\><C-n>]], opts)
            vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
            vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
            vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
            vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
            vim.opt_local.number = false
            vim.opt_local.relativenumber = false
            vim.cmd "startinsert"
          end,
        },
      },
    },
  },
}
