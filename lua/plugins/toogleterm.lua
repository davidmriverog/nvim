return {
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
      require('toggleterm').setup({
        -- Configuración mínima
        open_mapping = [[<leader>tt]],  -- Keymap para abrir/cerrar
        direction = 'horizontal',       -- Dirección de la terminal
        start_in_insert = true,        -- Comenzar en modo insertar
        close_on_exit = true,          -- Cerrar cuando el proceso termine
      })

      -- Keymap para salir del modo terminal (Esc)
      vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', {desc = "Salir del modo terminal"})
    end
  }
}
