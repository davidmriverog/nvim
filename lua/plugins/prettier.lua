return {
  "MunifTanjim/prettier.nvim",
  lazy = true,
  event = "BufReadPre",
  config = function()
    require("prettier").setup({
      bin = "prettier", -- command to run
      filetypes = {
        "css",
        "graphql",
        "html",
        "javascript",
        "javascriptreact",
        "json",
        "less",
        "markdown",
        "scss",
        "typescript",
        "typescriptreact",
        "yaml",
        "php", -- Add php to the filetypes list
      },
    })
  end,
}