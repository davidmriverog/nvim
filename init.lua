local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- vim.g.mapleader = " "
-- vim.g.maplocalleader = " "
vim.g.mapleader = ' '       -- Usa Espacio como líder principal
vim.g.maplocalleader = '\\' -- Líder local para buffers específicos

require("lazy").setup("plugins", {
  change_detection = {
    notify = false,
  },
})

require('bomb.globals')
require('bomb.remaps')
require('bomb.options')
vim.cmd("colorscheme tokyonight-moon")
-- vim.cmd('hi IlluminatedWordText guibg=none gui=underline')
-- vim.cmd('hi IlluminatedWordRead guibg=none gui=underline')
-- vim.cmd('hi IlluminatedWordWrite guibg=none gui=underline')
require('nvim-highlight-colors').setup({
  enable_named_colors = false,
})
