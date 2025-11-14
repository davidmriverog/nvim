return {
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Trouble",
    opts = {
      position = "botton",
      use_diagnostic_signs = true,
    },
    keys = {
      { "<leader>tt", "<cmd>TroubleToggle<CR>", desc = "Abrir/Cerrar Trouble" },
    },
  },
}
