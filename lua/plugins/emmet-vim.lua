return {
    "mattn/emmet-vim",
    ft = { "html", "php", "blade", "css", "scss", "javascript", "typescript", "vue" },
    init = function()
        vim.g.user_emmet_leader_key = "<A-d>" -- Tecla para activar Emmet
        vim.g.user_emmet_mode = "n"       -- Solo modo Normal (más seguro)
        vim.g.user_emmet_settings = {
            -- Configuraciones específicas para PHP/Blade
            php = {
                extends = 'html',
                filters = 'c',
            },
            blade = {
                extends = 'html',
            },
        }
    end,
    config = function()
        -- Configuración adicional si es necesaria
        vim.keymap.set({ 'i', 'n' }, '<A-d>', '<Plug>(emmet-expand-abbr)', { remap = true, silent = true })
    end
}
