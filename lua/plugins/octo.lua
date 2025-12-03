return {
  "pwntester/octo.nvim",
  cmd = "Octo",
  opts = {
    -- or "fzf-lua" or "snacks" or "default"
    -- picker = "telescope",
    picker = "snacks",
    -- bare Octo command opens picker of commands
    enable_builtin = true,
  },
  keys = {
    {
      "<leader>Go",
      "<cmd>Octo<cr>",
      desc = "Octo Actions"
    },
    {
      "<leader>Gp",
      "<CMD>Octo pr list<CR>",
      desc = "List GitHub PullRequests",
    },
    {
      "<leader>Gs",
      "<CMD>Octo pr search<CR>",
      desc = "Search Pull Requests",
    },
    {
      "<leader>Gc",
      "<CMD>Octo pr create<CR>",
      desc = "Create Pull Requests",
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    -- OR "ibhagwan/fzf-lua",
    "folke/snacks.nvim",
    "nvim-tree/nvim-web-devicons",
  },
}
