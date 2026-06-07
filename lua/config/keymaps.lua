
-- Setup <leader> in keymapping
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", {desc = "Remove search highlights"})
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", {desc = "Exit terminal mode"})

-- Navigate between windows. Ctrl + h/l/j/k
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", {desc = "Move focus to left window"})
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", {desc = "Move focus to right window"})
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", {desc = "Move focus to lower window"})
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", {desc = "Move focus to upper window"})

-- Split windows
vim.keymap.set("n", "<leader>wv", ":vsplit<cr>", {desc = "[W]indow Split [V]ertical"})
vim.keymap.set("n", "<leader>wh", ":split<cr>", {desc = "[W]indow Split [H]orizontal"})

-- Indent left/right in view mode. 
vim.keymap.set("v", "<", "<gv", {desc = "Indent left in visual mode"})
vim.keymap.set("v", ">", ">gv", {desc = "Indent left in visual mode"})

