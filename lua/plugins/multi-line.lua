-- This file contains the configuration for the vim-multiple-cursors plugin in Neovim.

return {
  {
    "mg979/vim-visual-multi",
    event = "VeryLazy",
    init = function()
      vim.g.VM_default_mappings = 0
      vim.g.VM_maps = {
        ["Find Under"] = "",
      }
      vim.g.VM_add_cursor_at_pos_no_mappings = 1
    end,
  },
  {
    "hinell/move.nvim",
  },
}
