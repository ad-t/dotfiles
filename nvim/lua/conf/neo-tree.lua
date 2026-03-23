return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  keys = {
    { "<leader>n", "<cmd>Neotree toggle=true<cr>", desc = "Open file explorer" }
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    window = {
      position = "right",
    },
    filesystem = {
      follow_current_file = { enabled = true },
    },
  },
}
