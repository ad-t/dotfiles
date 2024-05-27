-- redundancy for : character
vim.keymap.set("n", ";", ":", { desc = "enter cmd mode" })
-- better escape key
vim.keymap.set("i", "jk", "<ESC>", { desc = "escape insert mode" })
vim.keymap.set("i", "kj", "<ESC>", { desc = "escape insert mode" })
-- moving between buffers
vim.keymap.set("n", "<tab>", ":bnext<CR>", { desc = "move to next buffer", silent = true })
vim.keymap.set("n", "<S-tab>", ":bprevious<CR>", { desc = "move to previous buffer", silent = true })
-- close buffer
vim.keymap.set("n", "<leader>x", ":bdelete<CR>", { desc = "close buffer", silent = true })
-- show signcolumn all the time (TODO: figure out if this is actually doing anything)
