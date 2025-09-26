local symbols = require "conf.heirline.symbols"
local fg = "text"
local bg = "gray"

return {
  {
    provider = symbols.circle_right,
    hl = { fg = bg, bg = "cyan" }
  },
  {
    -- %l = current line number
    -- %L = number of lines in the buffer
    -- %c = column number
    -- %P = percentage through file of displayed window
    provider = "%7(%l/%L%):%c " .. symbols. circle_hollow_right .. " %P ",
    hl = { fg = fg, bg = bg },
  }
}
