return {
    {
        'nvim-lualine/lualine.nvim',
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            theme = 'dracula',
            -- Configuración comentada para personalización futura
            -- sections = {
            --     lualine_a = { 'mode' },
            --     lualine_b = { 'branch', 'diff', 'diagnostics' },
            --     lualine_c = { 'filename' },
            --     lualine_x = { 'encoding', 'fileformat', 'filetype' },
            --     lualine_y = { 'progress' },
            --     lualine_z = {
            --         function()
            --             return os.date("%H:%M") -- Formato de 24 horas: HH:MM
            --             -- Para formato de 12 horas con AM/PM: return os.date("%I:%M %p")
            --         end
            --     }
            -- }
        }
    }
}