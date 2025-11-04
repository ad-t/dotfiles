local fg = "text"
local bg = "gray"

return {
  {
    -- %l = current line number
    -- %L = number of lines in the buffer
    -- %c = column number
    -- %P = percentage through file of displayed window
    provider = "%7(%l/%L%):%c | %P ",
    hl = { fg = fg, bg = bg },
  }
}
