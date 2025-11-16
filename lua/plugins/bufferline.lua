return {
    'akinsho/bufferline.nvim',
    version = "*",
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },
    dependencies = 'nvim-tree/nvim-web-devicons',
  opts = {
    options = {
      mode = "buffers", -- también puedes usar "tabs"
      diagnostics = "nvim_lsp",
      always_show_bufferline = true,
      show_buffer_close_icons = true,
      show_close_icon = false,
      separator_style = "slant",
    },
  },
  keys = {
    { "<Tab>", "<cmd>BufferLineCycleNext<CR>", desc = "Buffer siguiente" },
    { "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", desc = "Buffer anterior" },
    { "<leader>bd", "<cmd>bdelete<CR>", desc = "Cerrar buffer actual" },
  },
}

