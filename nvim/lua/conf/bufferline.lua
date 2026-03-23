return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  opts = function()
    return {
      options = {
        mode = "buffers",
        themable = true,
        diagnostics = "nvim_lsp",
      },
    }
  end
}
