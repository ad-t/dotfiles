local treesitter_context = {
  "nvim-treesitter/nvim-treesitter-context",
  lazy = false,
  config = function()
    require("treesitter-context").setup {
      enable = true,
      mode = "topline",
      max_lines = 10,
      multiline_threshold = 1,
    }
  end
}

local treesitter = {
  'nvim-treesitter/nvim-treesitter',
  build = ":TSUpdate",
  branch = 'master',
  lazy = false,
  config = function()
    local config = require("nvim-treesitter.configs")

    config.setup({
      ensure_installed = {
        "bash",
        "c",
        "css",
        "dockerfile",
        "fish",
        "gitignore",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "nix",
        "proto",
        "terraform",
        "tsx",
        "typescript",
        "xml",
        "yaml",
      },
      auto_install = true,
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
      ignore_install = { 'org' },
    })
  end,
}

return {
  treesitter,
  treesitter_context,
}
