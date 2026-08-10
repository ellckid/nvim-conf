-- AstroLSP: сервера, форматирование на сохранении, LSP-биндинги.
---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    features = {
      codelens = true,
      inlay_hints = false,
      semantic_tokens = true,
    },
    -- Format on save (как было через conform)
    formatting = {
      format_on_save = { enabled = true },
      disabled = {},
      timeout_ms = 5000,
    },
    -- Сервера для автонастройки
    servers = { "lua_ls", "ts_ls", "eslint" },
    config = {
      ts_ls = {
        init_options = {
          preferences = {
            importModuleSpecifierPreference = "non-relative",
            includeCompletionsForModuleExports = true,
            includeCompletionsForImportStatements = true,
          },
        },
      },
      lua_ls = {
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
          },
        },
      },
      eslint = {
        settings = { workingDirectory = { mode = "auto" } },
      },
    },
    -- Твои LSP-биндинги (вешаются при LspAttach)
    mappings = {
      n = {
        K = {
          function()
            -- Если на строке есть диагностика — показать ошибку, иначе LSP hover.
            local line = vim.api.nvim_win_get_cursor(0)[1] - 1
            if #vim.diagnostic.get(0, { lnum = line }) > 0 then
              vim.diagnostic.open_float(nil, { focus = false, border = "rounded", source = true })
            else
              vim.lsp.buf.hover()
            end
          end,
          desc = "Ошибка / Hover",
        },
        gd = {
          function()
            vim.lsp.buf.definition()
          end,
          desc = "Перейти к определению",
        },
        gr = {
          function()
            vim.lsp.buf.references()
          end,
          desc = "Ссылки",
        },
        ["<Leader>D"] = {
          function()
            vim.lsp.buf.type_definition()
          end,
          desc = "Определение типа",
        },
        ["<Leader>rn"] = {
          function()
            vim.lsp.buf.rename()
          end,
          desc = "Переименовать",
          cond = "textDocument/rename",
        },
        ["<Leader>ca"] = {
          function()
            vim.lsp.buf.code_action()
          end,
          desc = "Code action",
          cond = "textDocument/codeAction",
        },
      },
      v = {
        ["<Leader>ca"] = {
          function()
            vim.lsp.buf.code_action()
          end,
          desc = "Code action",
          cond = "textDocument/codeAction",
        },
      },
    },
  },
}
