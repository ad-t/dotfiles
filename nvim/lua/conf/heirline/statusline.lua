local space = require("conf.heirline.components.space")
local spacer = require("conf.heirline.components.spacer")
local ruler = require("conf.heirline.components.ruler")
local lsp = require("conf.heirline.components.lsp")
local diagnostics = require("conf.heirline.components.diagnostics")
local filename = require("conf.heirline.components.filename")
local git = require("conf.heirline.components.git")

return {
  git,
  space,
  diagnostics,
  spacer,
  filename,
  spacer,
  lsp,
  ruler,
}
