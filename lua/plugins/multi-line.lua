-- This file contains the configuration for the vim-multiple-cursors plugin in Neovim.

return {
  {
    -- Plugin: vim-multiple-cursors
    -- URL: https://github.com/terryma/vim-multiple-cursors
    -- Description: A Vim plugin that allows multiple cursors for simultaneous editing.
    "terryma/vim-multiple-cursors",
  },
  {
    "hinell/move.nvim",
  },
  {
    "brenton-leighton/multiple-cursors.nvim",
    version = "*", -- Use the latest tagged version
    opts = {}, -- This causes the plugin setup function to be called
    keys = {
      { "<C-j>", "<Cmd>MultipleCursorsAddDown<CR>", mode = { "n", "x" }, desc = "Add cursor and move down" },
      { "<C-k>", "<Cmd>MultipleCursorsAddUp<CR>", mode = { "n", "x" }, desc = "Add cursor and move up" },

      { "<C-Up>", "<Cmd>MultipleCursorsAddUp<CR>", mode = { "n", "i", "x" }, desc = "Add cursor and move up" },
      { "<C-Down>", "<Cmd>MultipleCursorsAddDown<CR>", mode = { "n", "i", "x" }, desc = "Add cursor and move down" },

      { "<C-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>", mode = { "n", "i" }, desc = "Add or remove cursor" },
    },
  },
}
