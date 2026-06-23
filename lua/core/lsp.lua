-- Built-in LSP (Neovim 0.11+)

-- Отключаем pull-диагностику — ts_ls/eslint падают с "path undefined" при pull-запросах
vim.lsp.handlers["textDocument/diagnostic"] = function() end

vim.diagnostic.config {
  update_in_insert = false,
  float = { border = "rounded" },
  virtual_text = false,
  virtual_lines = { current_line = true },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "E ",
      [vim.diagnostic.severity.WARN] = "W ",
      [vim.diagnostic.severity.INFO] = "I ",
      [vim.diagnostic.severity.HINT] = "H ",
    },
  },
  underline = true,
}

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local buf = ev.buf

    if vim.bo[buf].buftype ~= "" or vim.api.nvim_buf_get_name(buf) == "" then
      return
    end

    if client and client.supports_method "textDocument/completion" then
      vim.lsp.completion.enable(true, client.id, buf, { autotrigger = true })
    end

    -- Inlay hints (0.10+)
    if client and client.supports_method "textDocument/inlayHint" then
      vim.lsp.inlay_hint.enable(true, { bufnr = buf })
    end

    local opts = function(desc)
      return { buffer = buf, desc = desc }
    end

    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts "LSP: Hover docs")
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts "LSP: Go to definition")
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts "LSP: Go to declaration")
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts "LSP: Go to implementation")
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts "LSP: References")
    vim.keymap.set("n", "<Leader>D", vim.lsp.buf.type_definition, opts "LSP: Type definition")
    vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, opts "LSP: Rename")
    vim.keymap.set({ "n", "v" }, "<Leader>ca", vim.lsp.buf.code_action, opts "LSP: Code action")
    vim.keymap.set({ "n", "v" }, "<Leader>ka", vim.lsp.buf.code_action, opts "LSP: Code action")
    vim.keymap.set("n", "<Leader>ds", vim.lsp.buf.document_symbol, opts "LSP: Document symbols")
    vim.keymap.set("n", "<Leader>co", function()
      vim.lsp.buf.code_action {
        apply = true,
        context = { only = { "source.organizeImports" }, diagnostics = {} },
      }
    end, opts "LSP: Organize imports")
    vim.keymap.set("n", "<Leader>ko", function()
      vim.lsp.buf.code_action {
        apply = true,
        context = { only = { "source.organizeImports" }, diagnostics = {} },
      }
    end, opts "LSP: Organize imports")
    vim.keymap.set("n", "<Leader>ih", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = buf }, { bufnr = buf })
    end, opts "LSP: Toggle inlay hints")
  end,
})

vim.lsp.config("lua_ls", {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
    },
  },
})

vim.lsp.config("ts_ls", {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
  init_options = {
    preferences = {
      importModuleSpecifierPreference = "non-relative",
      includeCompletionsForModuleExports = true,
      includeCompletionsForImportStatements = true,
      includeInlayParameterNameHints = "none",
      includeInlayParameterNameHintsWhenArgumentMatchesName = false,
      includeInlayFunctionParameterTypeHints = false,
      includeInlayVariableTypeHints = false,
      includeInlayVariableTypeHintsWhenTypeMatchesName = false,
      includeInlayPropertyDeclarationTypeHints = false,
      includeInlayFunctionLikeReturnTypeHints = false,
      includeInlayEnumMemberValueHints = false,
    },
  },
})

vim.lsp.config("eslint", {
  cmd = { "vscode-eslint-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_markers = { ".eslintrc", ".eslintrc.js", ".eslintrc.json", "eslint.config.js", "package.json" },
  settings = {
    workingDirectory = { mode = "auto" },
  },
})

vim.lsp.enable { "lua_ls", "ts_ls", "eslint" }
