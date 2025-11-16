-- ============================================================================
-- CONFIGURACIÓN DE TECLAS GLOBALES
-- ============================================================================
-- NOTA: Las teclas líder se configuran en config/lazy.lua antes de cargar plugins

-- Deshabilitar netrw (usamos Oil.nvim)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local wk = require("which-key")

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
vim.keymap.set("n", "<A-Down>", ":MoveLine 1<CR>", opts)
vim.keymap.set("n", "<A-Up>", ":MoveLine -1<CR>", opts)
vim.keymap.set("n", "<A-S-Left>", ":MoveWord -1<CR>", opts)
vim.keymap.set("n", "<A-S-Right>", ":MoveWord 1<CR>", opts)

-- Visual-mode commands
vim.keymap.set("x", "<A-Down>", ":MoveBlock 1<CR>", opts)
vim.keymap.set("x", "<A-Up>", ":MoveBlock -1<CR>", opts)
vim.keymap.set("v", "<A-Left>", ":MoveHBlock -1<CR>", opts)
vim.keymap.set("v", "<A-Right>", ":MoveHBlock 1<CR>", opts)

vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr>", { desc = "Save File" })
