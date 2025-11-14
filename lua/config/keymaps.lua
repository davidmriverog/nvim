-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local wk = require("which-key")

wk.add({
  { "<leader>m", group = "+Visual Multi" }, -- group
  { "<leader>ma", "<Plug>(VM-Select-All)<Tab>", desc = "Select All", mode = "n" },
  { "<leader>ma", "<Plug>(VM-Select-All)<Tab>", desc = "Select All", mode = "n" },
  { "<leader>mr", "<Plug>(VM-Start-Regex-Search)", desc = "Start Regex Search", mode = "n" },
  { "<leader>mp", "<Plug>(VM-Add-Cursor-At-Pos)", desc = "Add Cursor At Pos", mode = "n" },
  { "<leader>mo", "<Plug>(VM-Toggle-Mappings)", desc = "Toggle Mapping", mode = "n" },
})

wk.add({
  { "<leader>T", group = "+Tools Compa" },
  {
    "<leader>Tn",
    function()
      vim.cmd(':TermExec cmd="npm run start:dev"')
    end,
    desc = "NestJS Run App",
    mode = "n",
  },
})
