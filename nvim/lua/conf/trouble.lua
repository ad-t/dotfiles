return {
  "folke/trouble.nvim",
  lazy = false,
  keys = {
    { "<leader>p", "<cmd>Trouble diagnostics toggle<cr>", desc = "Toggle trouble diagnostics window" }
  },
  opts = {
    modes = {
      diagnostics = {
        auto_open = false,
      }
    },
    warn_no_results = false,
    open_no_results = true,
    auto_close = true,
    severity = vim.diagnostic.severity.ERROR,
    height = 7,
    focus = true,
  }
}
