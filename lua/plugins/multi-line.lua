-- This file contains the configuration for the vim-multiple-cursors plugin in Neovim.

return {
  {
    "mg979/vim-visual-multi",
    lazy = false, -- Set to false to ensure it loads before other configurations
    init = function()
      -- Your configuration goes here if needed
      
      vim.g.VM_default_mappings = 0
      vim.g.VM_maps = {
          ['Find Under'] = '',
          ["Select Cursor Down"] = '<C-A-S-Down>',     -- start selecting down
          ["Select Cursor Up"]   = '<C-A-S-Up>',   
          ["Add Cursor Down"] = '<C-A-Down>',
          ["Add Cursor Up"]   = '<C-A-Up>',
      }
      vim.g.VM_add_cursor_at_pos_no_mappings = 1
    end,
  },
  {
    "hinell/move.nvim",
  },
}
