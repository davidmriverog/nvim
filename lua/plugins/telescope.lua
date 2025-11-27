-- ============================================================================
-- TELESCOPE - BUSCADOR DIFUSO Y NAVEGADOR DE ARCHIVOS
-- ============================================================================
return {
  { "nvim-telescope/telescope-live-grep-args.nvim", event = "VeryLazy" },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    keys = {
      -- Búsqueda de archivos y contenido
      --{ "<leader><space>", "<cmd>Telescope find_files<cr>", desc = "Buscar archivos en el proyecto" },
      -- { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Buscar archivos en el proyecto" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>",     desc = "Buscar archivos recientes" },
      {
        "<leader>fg",
        function()
          require("telescope.builtin").grep_string({ search = vim.fn.input("Buscar texto > ") })
        end,
        desc = "Buscar texto en todos los archivos"
      },
      { "<leader>ba", "<cmd>Telescope buffers<cr>",      desc = "Buscar entre buffers abiertos" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>",    desc = "Buscar en la ayuda de Neovim" },
  
      -- Integración con Git
      { "<leader>fs", "<cmd>Telescope git_files<cr>",    desc = "Buscar archivos rastreados por Git" },
      { "<leader>gs", "<cmd>Telescope git_status<cr>",   desc = "Ver estado de Git" },
      { "<leader>gc", "<cmd>Telescope git_commits<cr>",  desc = "Ver historial de commits" },
      { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Cambiar entre ramas de Git" },
    },
    config = function()
      -- Configuración de colores personalizados para Telescope
      vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = '#1e222a' })
      vim.api.nvim_set_hl(0, 'TelescopeBorder', { fg = '#5d677a', bg = '#1e222a' })
      vim.api.nvim_set_hl(0, 'TelescopePromptNormal', { fg = '#abb2bf', bg = '#1e222a' })
      vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { fg = '#5d677a', bg = '#1e222a' })
      vim.api.nvim_set_hl(0, 'TelescopePromptTitle', { fg = '#1e222a', bg = '#5d677a' })
      vim.api.nvim_set_hl(0, 'TelescopePreviewTitle', { fg = '#1e222a', bg = '#98c379' })
      vim.api.nvim_set_hl(0, 'TelescopeResultsTitle', { fg = '#1e222a', bg = '#61afef' })
  
      require("telescope").setup({
        defaults = {
          file_ignore_patterns = { "node_modules", "%.git/" },
          layout_strategy = "horizontal",
          layout_config = { prompt_position = "top" },
          sorting_strategy = "descending",
          winblend = 0,
        },
      })
    end,
  }
}

