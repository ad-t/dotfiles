-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
--
-- Set cursor to block
vim.opt.guicursor = ""

-- make sure undos don't leak between
-- sessions
vim.o.undofile = false

-- Remap jk and kj to be escape characters
vim.keymap.set('i', 'kj', "<Esc>")
vim.keymap.set('i', 'jk', "<Esc>")
