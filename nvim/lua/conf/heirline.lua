return {
  "rebelot/heirline.nvim",
  event = "UiEnter",
  config = function()
    local statusline = require("conf.heirline.statusline")
    local colors = require("conf.heirline.colors")
    require("heirline").setup({
      statusline = statusline,
      opts = {
        colors = colors
      }
    })
  end
}
