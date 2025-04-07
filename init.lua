--[[
  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--]]

vim.cmd [[packadd packer.nvim]]

-- ========================================================================== --
--                              Plugin Management                             --
-- ========================================================================== --
require('packer').startup(function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'

  -- Core plugins
  use 'nvim-tree/nvim-tree.lua'            -- File explorer
  use 'sindrets/diffview.nvim'             -- Git diff viewer
  use 'nvim-telescope/telescope.nvim'      -- Fuzzy finder
  use 'romgrk/barbar.nvim'                 -- Tab bar
  use 'nvim-treesitter/nvim-treesitter'    -- Syntax highlighting
  use 'styled-components/vim-styled-components' -- Styled Components support
  use 'nvim-tree/nvim-web-devicons'        -- Иконки для barbar.nvim

  -- Theme 
  use 'stevearc/dressing.nvim' -- Улучшение UI элементов
  use 'lewis6991/gitsigns.nvim' -- Значки гита
  use 'sainnhe/everforest'
  use 'xiyaowong/transparent.nvim' -- Прозрачность

  -- LSP ecosystem
  use 'williamboman/mason.nvim'            -- LSP manager
  use 'williamboman/mason-lspconfig.nvim'  -- Mason-LSP bridge
  use 'neovim/nvim-lspconfig'              -- LSP configurations
  use 'hrsh7th/nvim-cmp'                   -- Autocompletion core
  use 'hrsh7th/cmp-nvim-lsp'               -- LSP completion source
  use 'jose-elias-alvarez/null-ls.nvim'    -- Code formatting/diagnostics
  use 'MunifTanjim/prettier.nvim'          -- Prettier integration

  -- Utilities
  use 'nvim-lua/plenary.nvim'              -- Required for Telescope
end)

-- ========================================================================== --
--                               Plugin Configs                               --
-- ========================================================================== --

-- Treesitter (Syntax Highlighting) ------------------------------------------
require('nvim-treesitter.configs').setup({
  highlight = { enable = true },
  ensure_installed = {
    'typescript', 'javascript', 'tsx', 'lua',
    'css', 'scss', 'html', 'json'
  },
})

-- Mason (LSP Manager) ------------------------------------------------------
require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = { 'tsserver', 'cssls', 'lua_ls', 'eslint' }
})

-- Setup nvim-cmp (Autocompletion) ------------------------------------------
local cmp = require('cmp')
local cmp_lsp = require('cmp_nvim_lsp')

cmp.setup({
  sources = {
    { name = 'nvim_lsp' }
  }
})

-- LSP Servers --------------------------------------------------------------
local lsp = require('lspconfig')

local servers = {
  tsserver = {},
  cssls = {},
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' }
        }
      }
    }
  },
  eslint = {
    settings = {
      packageManager = 'npm'
    }
  }
}

for server, config in pairs(servers) do
  lsp[server].setup({
    capabilities = cmp_lsp.default_capabilities(),
    on_attach = function(client, bufnr)
      -- Common LSP keymaps
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr })
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr })
      vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, {
        buffer = bufnr,
        desc = 'Code actions'
      })
    end
  })
end

-- Null-ls (Formatting/Linting) ---------------------------------------------
local null_ls = require('null-ls')

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettierd.with({
      filetypes = {
        'javascript', 'javascriptreact', 'typescript', 'typescriptreact',
        'css', 'scss', 'json', 'html', 'markdown'
      },
    }),
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.code_actions.eslint_d,
  },
})

-- Prettier -----------------------------------------------------------------
require('prettier').setup({
  bin = 'prettierd',
  filetypes = {
    'css', 'scss', 'javascript', 'javascriptreact',
    'typescript', 'typescriptreact', 'json', 'markdown'
  }
})

-- Telescope (Fuzzy Finder) -------------------------------------------------
require('telescope').setup({
  defaults = {
    mappings = {
      i = { ['<C-s>'] = require('telescope.actions').select_horizontal }
    }
  }
})

-- Nvim-Tree (File Explorer) ------------------------------------------------
require('nvim-tree').setup({
  view = {
    width = 100,
    side = "left",
  },
  renderer = {
    highlight_git = true,
    highlight_opened_files = 'name',
    indent_markers = {
      enable = true,
      icons = {
        corner = '└ ',
        edge = '│ ',
        item = '│ ',
        none = '  ',
      },
    },
    icons = {
      webdev_colors = false,
      git_placement = 'after',
      show = {
        git = true,
        folder = true,
        file = true,
        folder_arrow = true,
      },
    },
  },
})

-- Barbar (Tabs) ------------------------------------------------------------
require('barbar').setup({
  icons = {
    filetype = {
      enabled = true,
      custom_colors = false,
    },
  },
  highlight_visible = false,
  highlight_inactive_file_icons = false,
  auto_hide = false
})

-- Diffview (Git) -----------------------------------------------------------
require('diffview').setup({ enhanced_diff_hl = true })

-- use System buffer
vim.opt.clipboard:append({ "unnamed" })   -- для macOS
-- Гибридные номера (абсолютный для текущей строки + относительные для остальных)
vim.opt.number = true
vim.opt.relativenumber = true


-- ========================================================================== --
--                                 Theme                                      --
-- ========================================================================== --

vim.g.everforest_background = 'hard'      -- Максимальная контрастность
vim.g.everforest_enable_italic = 1       -- Курсив для комментариев
vim.g.everforest_transparent_background = 2 -- Полупрозрачный фон
vim.g.everforest_diagnostic_virtual_text = 'colored' -- Цветной текст диагностики

-- Применить тему
vim.cmd[[
  colorscheme everforest
  highlight Normal guibg=#2b3339
  highlight WinSeparator guifg=#543c2c
  highlight CursorLine guibg=#364247
  highlight WinSeparator guifg=#6272A4 guibg=NONE
  highlight CursorLine guibg=#343746
  highlight Folded guibg=#343746 guifg=#6272A4
  highlight MatchParen guibg=#44475a gui=bold
  highlight NvimTreeFolderIcon guifg=#8BE9FD
  highlight NvimTreeIndentMarker guifg=#6272A4
  highlight TelescopeTitle guifg=#BD93F9
  highlight TelescopeSelection guibg=#343746
  highlight BufferCurrent guibg=#343746
  highlight BufferInactive guifg=#6272A4
  highlight LspFloatWinNormal guibg=NONE
]]

-- Настройка прозрачности
require('transparent').setup({
  groups = {
    'Normal', 'NormalNC', 'Comment', 'Constant', 'Special',
    'Identifier', 'Statement', 'PreProc', 'Type', 'Underlined',
    'Todo', 'String', 'Function', 'Conditional', 'Repeat',
    'Operator', 'Structure', 'LineNr', 'NonText', 'SignColumn',
    'CursorLineNr', 'EndOfBuffer', 'NvimTreeNormal', 'NvimTreeEndOfBuffer',
    'TelescopeBorder', 'TelescopePromptBorder', 'TelescopeResultsBorder',
    'TelescopePreviewBorder', 'TelescopeNormal', 'TelescopePromptNormal',
    'TelescopePreviewNormal', 'TelescopeSelection', 'TelescopeTitle',
    'WhichKeyFloat', 'NotifyBackground', 'FloatBorder', 'WinSeparator',
    'BufferCurrent', 'BufferVisible', 'BufferInactive', 'TabLine',
    'TabLineFill', 'TabLineSel', 'StatusLine', 'StatusLineNC',
  },
  extra_groups = {
    'GitSignsAdd',
    'GitSignsChange',
    'GitSignsDelete',
    'DiagnosticError',
    'DiagnosticWarn',
    'DiagnosticInfo',
    'DiagnosticHint',
  },
})

-- Дополнительные настройки внешнего вида
vim.opt.termguicolors = true  -- Включить true-цвета
vim.opt.winblend = 20         -- Прозрачность плавающих окон
vim.opt.pumblend = 20         -- Прозрачность автодополнения

-- Дополнительные кастомные настройки
vim.cmd[[
  " Глобальные настройки
  highlight WinSeparator guifg=#6272A4 guibg=NONE
  highlight CursorLine guibg=#343746
  highlight Folded guibg=#343746 guifg=#6272A4
  highlight MatchParen guibg=#44475a gui=bold
  
  " Настройки для плагинов
  highlight NvimTreeFolderIcon guifg=#8BE9FD
  highlight NvimTreeIndentMarker guifg=#6272A4
  highlight TelescopeTitle guifg=#BD93F9
  highlight TelescopeSelection guibg=#343746
  highlight BufferCurrent guibg=#343746
  highlight BufferInactive guifg=#6272A4
  highlight LspFloatWinNormal guibg=NONE
]]

-- Настройка компонентов интерфейса
require('gitsigns').setup({
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
  sign_priority = 9,
  current_line_blame = true,
})

require('dressing').setup({
  input = {
    relative = 'cursor',
    border = 'rounded',
    win_options = {
      winblend = 20,
    },
  },
  select = {
    backend = { 'telescope', 'builtin' },
    builtin = {
      win_options = {
        winblend = 20,
      },
    },
  },
})


-- ========================================================================== --
--                                 Keymaps                                   --
-- ========================================================================== --

vim.g.mapleader = ' '

-- General
vim.keymap.set('i', 'jk', '<ESC>', { noremap = true, silent = true })
vim.keymap.set('n', '<S-h>', '^', { noremap = true, silent = true })
vim.keymap.set('n', '<S-l>', '$', { noremap = true, silent = true })

-- Plugin Shortcuts
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>gg', ':DiffviewOpen<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fs', ':Telescope live_grep<CR>', { noremap = true, silent = true })

-- Tabs Management
vim.keymap.set('n', '<leader>tp', ':BufferPin<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>x', ':BufferClose<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Tab>', ':BufferNext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<S-Tab>', ':BufferPrevious<CR>', { noremap = true, silent = true })

-- Window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to left window', noremap = true, silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to lower window', noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to upper window', noremap = true, silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to right window', noremap = true, silent = true })

-- ========================================================================== --
--                                Autocommands                               --
-- ========================================================================== --

-- Autoformat on Save
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.js', '*.jsx', '*.ts', '*.tsx', '*.css', '*.scss', '*.json' },
  callback = function() vim.lsp.buf.format({ async = false }) end
})

-- Highlight on Yank
vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = '*',
  callback = function() vim.highlight.on_yank({ timeout = 300 }) end
})
