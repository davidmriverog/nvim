return {
  "nvim-java/nvim-java",
  dependencies = {
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-jdtls",         -- The actual jdtls plugin
    "nvim-treesitter/nvim-treesitter", -- For syntax highlighting and analysis
    "mfussenegger/nvim-dap",           -- For debugging
    "rcarriga/nvim-dap-ui",            -- Debugging UI
    -- other general LSP/DAP dependencies you may have
  },
  ft = "java", -- Only load this plugin for Java files
  config = function()
    require("java").setup({
      -- your custom nvim-java configuration here
    })
  end,
}
