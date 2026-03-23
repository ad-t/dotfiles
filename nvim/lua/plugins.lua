local colors = require("conf.colors")
local heirline = require("conf.heirline")
local gitsigns = require("conf.gitsigns")
local treesitter = require("conf.treesitter")
local lsp        = require("conf.lsp")
local nvim_colorizer = require("conf.nvim-colorizer")
local fzf            = require("conf.fzf")
local bufferline     = require("conf.bufferline")
local nvim_cmp = require("conf.nvim-cmp")
local trouble  = require("conf.trouble")
local outline  = require("conf.outline")
local neo_tree = require("conf.neo-tree")
local noice    = require("conf.noice")
local ts_autotag = require("conf.ts-autotag")
local render_markdown = require("conf.render-markdown")
local orgmode         = require("conf.orgmode")

return {
  "folke/which-key.nvim",
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  "folke/neodev.nvim",
  -- colorscheme
  colors,
  -- util
  heirline,
  gitsigns,
  treesitter,
  nvim_colorizer,
  -- searching
  fzf,
  bufferline,
  -- to enable language server autodownloading & setup
  { "neovim/nvim-lspconfig" },
  { "mason-org/mason.nvim" },
  lsp,
  -- autocompletion
  nvim_cmp,
  -- present all the file errors in a window
  trouble,
  outline,
  -- file exploring
  neo_tree,
  -- notifications
  noice,
  ts_autotag,
  render_markdown,
  orgmode,
}
