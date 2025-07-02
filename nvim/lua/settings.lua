vim.cmd.signcolumn = yes
-- block cursor
vim.opt.guicursor = ""
-- make sure undos don't leak between sessions
vim.o.undofile = false
-- change colorscheme
vim.cmd.colorscheme "gruvbox-material"
-- show the cursorline where your cursor is
vim.o.cursorline = true
-- enable mouse input
vim.o.mouse = "a"
-- interval for writing wraps to disk (used also by gitsigns)
vim.o.updatetime = 500
-- indenting
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.smartindent = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.number = true
vim.o.numberwidth = 5
-- prevent other overrides
vim.g.editorconfig = false

-- configuring values on specific lsps (TODO: move somewhere else)
vim.lsp.config['vtsls'] = {
  settings = {
    typescript = {
      tsserver = {
        maxTsServerMemory = 8196,
      }
    }
  }
}
