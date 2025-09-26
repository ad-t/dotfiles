local conditions = require("heirline.conditions")
local symbols    = require("conf.heirline.symbols")

local fg = "bg"
local bg = "cyan"

return {
  {
    provider = function()
      return symbols.circle_right
    end,
    hl = { fg = bg, bg = "bright_bg" },
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
      return " " .. table.concat(names, " " .. symbols.circle_hollow_right .. " ") .. " "
    end,
    hl = { bg = bg, fg = fg },
  }
}
