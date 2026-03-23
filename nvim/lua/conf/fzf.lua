return {
  "ibhagwan/fzf-lua",
  lazy = true,
  keys = {
    { "<leader>ff", "<cmd>lua require('fzf-lua').files()<cr>", { silent = true } },
  },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    fzf_args = vim.env.FZF_DEFAULT_OPTS,
    winopts = {
      border = false,
      preview = {
        hidden = "hidden"
      }
    }
  },
}
