return {
    -- Identacion php embed HTML 
    {
        "captbaritone/better-indent-support-for-php-with-html",
    },
    -- Marks
    {
        "chentoast/marks.nvim",
        event = "VeryLazy",
        opts = {},
    },
    -- TODO: tienes que hacer tal cosa
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        cmd = "Trouble",
        opts = {
            position = "bottom",
            icons = true,
            use_diagnostic_signs = true,
        },
        keys = {
            { "<leader>tt", "<cmd>TroubleToggle<CR>", desc = "Abrir/cerrar Trouble" },
        }
    },
    --Contraer y extender lineas para mejor visualizacion
    {
        'kevinhwang91/nvim-ufo',
        dependencies = {
            'kevinhwang91/promise-async'
        },
        opts = {
            provider_selector = function(bufnr, filetype, buftype)
                return { 'treesitter', 'indent' }
            end
        },
        config = function(_, opts)
            -- Configuración necesaria para folding
            vim.o.foldcolumn = '0' -- '0' para ocultar la columna de fold
            vim.o.foldlevel = 99   -- niveles altos para no plegar por defecto
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true

            require('ufo').setup(opts)

            -- Keymap para alternar el fold bajo el cursor
            vim.keymap.set('n', '<leader>z', 'za', { silent = true, noremap = true, desc = "Toggle fold" })
        end
    },
    --Colores para indificar el cierre facilmente de ([{}])
    {
        "HiPhish/rainbow-delimiters.nvim",
        config = function()
            require("rainbow-delimiters.setup")()
        end,
    },
    -- Neovim notifications and LSP progress messages
    {
        "j-hui/fidget.nvim",
    },
    {
        "nvchad/showkeys",
        cmd = "ShowkeysToggle",
        opts = {
            timeout = 3,        -- Aumentado de 1 a 3 segundos para reducir frecuencia
            maxkeys = 4,        -- Reducido de 6 a 4 para evitar sobrecarga
            position = "top-right",  -- Cambiado para evitar conflictos con lualine
            show_count = true,  -- Mostrar contador de repeticiones
            excluded_modes = { "i" }, -- Excluir modo insert para reducir ruido
        },
        config = function(_, opts)
            -- Configuración más robusta con manejo de errores
            local ok, showkeys = pcall(require, "showkeys")
            if not ok then
                vim.notify("Error loading showkeys plugin", vim.log.levels.ERROR)
                return
            end
            showkeys.setup(opts)
        end,
        keys = {
            {
                "<A-u>",
                function()
                    -- Manejo de errores mejorado
                    local ok, _ = pcall(vim.cmd, "ShowkeysToggle")
                    if not ok then
                        vim.notify("Error toggling showkeys", vim.log.levels.WARN)
                    end
                end,
                desc = "Show key presses",
            },
        },
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        ---@module "ibl"
        ---@type ibl.config
        config = function()
            require("ibl").setup()
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    },
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        config = function()
            vim.g.skip_ts_context_commentstring_module = true
            require("ts_context_commentstring").setup({
                enable_autocmd = false,
            })
        end,
    },
    { "lukas-reineke/virt-column.nvim", opts = { virtcolumn = "80" } },
    {
        "mbbill/undotree",
        config = function()
            vim.g.undotree_WindowLayout = 3 -- Estilo 3 (a la derecha)
        end
    },
    {
        'brenoprata10/nvim-highlight-colors',
        config = function()
            require('nvim-highlight-colors').setup({})
        end
    },
    { "tpope/vim-fugitive" },
}
