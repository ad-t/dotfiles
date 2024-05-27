vim.cmd.signcolumn = yes
-- block cursor
vim.opt.guicursor = ""
-- make sure undos don't leak between sessions
vim.o.undofile = false
-- change colorscheme
vim.cmd.colorscheme "catppuccin"
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
vim.o.softtabestop = 2
vim.o.number = true
vim.o.numberwidth = 5
