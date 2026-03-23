return {
  "mason-org/mason-lspconfig.nvim",
  config = function()
    -- we'd like to disable lsp logging, however
    -- still provide the ability to enable debug
    -- logging if required
    vim.lsp.set_log_level("off")
    -- vim.lsp.set_log_level("debug")
    -- enforce a specific loading order
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "ansiblels",
        "bashls",
        -- about to be deprecateed
        -- "bufls",
        -- in favour of this:
        "buf_ls",
        "clangd",
        "cssls",
        "dockerls",
        "eslint",
        "gopls",
        "html",
        "jsonls",
        "lua_ls",
        "markdown_oxide",
        "pyright",
        "taplo",
        "terraformls",
        "tflint",
        "tsgo",
        "lemminx",
        "yamlls",
      },
      automatic_installation = true,
    })
    vim.lsp.enable('tsgo')
    vim.lsp.enable('jdtls')
  end
}
