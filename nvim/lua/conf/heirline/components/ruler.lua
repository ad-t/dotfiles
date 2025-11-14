local symbols = require("conf.heirline.symbols")
local colors = require("conf.heirline.colors")
local fg = "text"
local bg = "gray"

return {
  {
    provider = symbols.angle_right,
    hl = { fg = bg, bg = colors.bright_bg },
  },
  {
    -- %l = current line number
    -- %L = number of lines in the buffer
    -- %c = column number
    -- %P = percentage through file of displayed window
    provider = " %l:%c ",
    hl = { fg = fg, bg = bg },
  },
  {
    provider = symbols.angle_right,
    hl = { bg = bg, fg = colors.bright_bg },
  },
  {
    provider = symbols.angle_right,
    hl = { fg = bg, bg = colors.bright_bg },
  },
  {
    provider = " %P ",
    hl = { fg = fg, bg = bg },
  }
}
