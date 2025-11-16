return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        lazy = true,
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        config = function()
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                -- Lenguajes
                ensure_installed = {
                    "lua", "javascript", "query", "typescript", "php", "go", "python", "html", "css", "json", "bash",
                    "dockerfile", "yaml", "toml", "markdown",
                },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true, -- Busca objetos automáticamente
                        keymaps = {
                            -- Objetos estándar
                            ["af"] = "@function.outer", -- [A]round [F]unction
                            ["if"] = "@function.inner", -- [I]nner [F]unction
                            ["ac"] = "@class.outer", -- [A]round [C]lass
                            ["ic"] = "@class.inner", -- [I]nner [C]lass

                            -- Personalizados para lenguajes específicos
                            ["aC"] = "@comment.outer", -- [A]round [C]omment (multilínea)
                            ["i,"] = "@parameter.inner", -- [I]nner [,] parámetros
                        },
                    },
                },

                -- Instalación automática al abrir un archivo, requiere treesitter cli
                auto_install = false,

                -- Habilita el resalto
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },

                -- Indentación mejorada
                indent = {
                    enable = true,
                    disable = { "yaml" }, -- YAML puede dar problemas con indentación
                },
                -- Colores para niveles por ejemplo ((()))
            })
        end
    }
}
