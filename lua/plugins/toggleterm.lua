return {
    {
        "akinsho/toggleterm.nvim",
        version = "*", -- use "*" for the latest stable release
        config = function()
            require("toggleterm").setup({
                -- your configuration options go here
                size = 10,
                hide_numbers = false,
                shade_filetypes = {},
                shade_terminals = true,
                start_in_insert = true,
                insert_mappings = false,
                persist_size = true,
                direction = "horizontal",
                close_on_exit = true,
                shell = "pwsh",
                open_mapping = [[<leader>tt]], -- or { [[<c-\>]], [[<c-¥>]] } if you also use a Japanese keyboard.
                float_opts = {
                    border = "curved",
                    winblend = 3,
                    highlights = {
                    border = "Normal",
                    background = "Normal",
                    },
                },
            })

            vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', {desc = "Salir del modo terminal"})
        end,
    },
}