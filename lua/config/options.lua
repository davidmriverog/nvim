-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options her
--
vim.opt.number = true
vim.opt.relativenumber = false

vim.opt.swapfile = false -- Desactiva archivos .swp (intercambio temporal)
vim.opt.backup = false -- No crea archivos de respaldo automáticamente

vim.opt.updatetime = 250 -- Tiempo de espera para escribir al archivo swap (ms)
vim.opt.timeoutlen = 300 -- Tiempo de espera para secuencias de teclas (ms)
