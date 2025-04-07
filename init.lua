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
    icons = {
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
  auto_hide = false
})

-- Diffview (Git) -----------------------------------------------------------
require('diffview').setup({ enhanced_diff_hl = true })

-- use System buffer
vim.opt.clipboard:append({ "unnamed" })   -- для macOS

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
