local conditions = require("heirline.conditions")
local symbols = require("conf.heirline.symbols")
local colors = require("conf.heirline.colors")

local fg = "bg"
local bg = "cyan"

return {
  {
    provider = symbols.angle_right,
    hl = { fg = bg, bg = colors.bright_bg },
  },
  {
    condition = conditions.lsp_attached,
    update = {'LspAttach', 'LspDetach'},

    -- You can keep it simple,
    -- provider = " [LSP]",

    -- Or complicate things a bit and get the servers names
    provider = function()
      local names = {}
      for i, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
        table.insert(names, server.name)
      end
      return " " .. table.concat(names, " " .. symbols.angle_right_thin .. " ") .. " "
    end,
    hl = { bg = bg, fg = fg },
  },
  {
    provider = symbols.angle_right,
    hl = { bg = bg, fg = colors.bright_bg },
  },
}
