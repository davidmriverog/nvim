-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local wk = require("which-key")
local map = LazyVim.safe_keymap_set

-- groups custom keymaps
wk.add({
  { "<leader>T", group = "+Tools" },
  {
    "<leader>Tn",
    function()
      vim.cmd(':TermExec cmd="npm run start:dev"')
    end,
    desc = "NestJS Run App",
    mode = "n",
  },
})

-- override keymaps

local opts = { noremap = true, silent = true }
-- Normal-mode commands
map("n", "<A-Down>", ":MoveLine 1<CR>", opts)
map("n", "<A-Up>", ":MoveLine -1<CR>", opts)
map("n", "<A-S-Left>", ":MoveWord -1<CR>", opts)
map("n", "<A-S-Right>", ":MoveWord 1<CR>", opts)

-- Visual-mode commands
map("x", "<A-Down>", ":MoveBlock 1<CR>", opts)
map("x", "<A-Up>", ":MoveBlock -1<CR>", opts)
map("v", "<A-Left>", ":MoveHBlock -1<CR>", opts)
map("v", "<A-Right>", ":MoveHBlock 1<CR>", opts)
