return {
  { "mfussenegger/nvim-jdtls", ft = { "kotlin", "java" } },
  {
    "elmcgill/springboot-nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-jdtls",
    },
    config = function()
      local springboot_nvim = require("springboot-nvim")
      springboot_nvim.setup({})
    end,
  },
}
