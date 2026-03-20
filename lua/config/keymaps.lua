-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

-- override keymaps

local opts = { noremap = true, silent = true }
-- Normal-mode commands
vim.keymap.set("n", "<A-Down>", ":MoveLine 1<CR>", opts)
vim.keymap.set("n", "<A-Up>", ":MoveLine -1<CR>", opts)
vim.keymap.set("n", "<A-S-Left>", ":MoveWord -1<CR>", opts)
vim.keymap.set("n", "<A-S-Right>", ":MoveWord 1<CR>", opts)

-- Visual-mode commands
vim.keymap.set("x", "<A-Down>", ":MoveBlock 1<CR>", opts)
vim.keymap.set("x", "<A-Up>", ":MoveBlock -1<CR>", opts)
vim.keymap.set("v", "<A-Left>", ":MoveHBlock -1<CR>", opts)
vim.keymap.set("v", "<A-Right>", ":MoveHBlock 1<CR>", opts)
