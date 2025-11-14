return {
  {
    "mg979/vim-visual-multi",
    init = function()
      vim.g.VM_default_mappings = 0
      vim.g.VM_maps = {
        ["Find Under"] = "<C-d>",
        ["Select Cursor Down"] = "<M-C-Down>",
        ["Select Cursor Up"] = "<M-C-Up>",
        ["Undo"] = "u",
        ["Redo"] = "<C-r>",
      }

      vim.g.VM_add_cursor_at_pos_no_mappings = 1
    end,
  },
}
