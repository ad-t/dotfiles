local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "clangd" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

vim.diagnostic.config {
  -- to prevent a lack of word-wrap making it impossible
  -- to read the error message
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
}

-- have the errors show in a little float instead
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

-- 
-- lspconfig.pyright.setup { blabla}
