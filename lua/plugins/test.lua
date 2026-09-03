return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-neotest/neotest-jest",
  },
  keys = {
    { "<leader>tr", "<cmd>Neotest run<cr>", desc = "Run Test" },
    { "<leader>ti", "<cmd>Neotest output<cr>", desc = "Output Test" },
    { "<leader>ts", "<cmd>Neotest summary<cr>", desc = "Summary Test" },
    { "<leader>ta", "<cmd>:lua require('neotest').run.run({ suite = true })<cr>", desc = "Toggle Suite Test" },
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-jest"),
      },
    })
  end,
}
