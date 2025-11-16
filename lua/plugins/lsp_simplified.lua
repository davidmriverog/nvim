-- ============================================================================
-- LSP CONFIGURATION - SIMPLIFIED VERSION
-- ============================================================================
return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        -- Autocompletado
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',
        -- snippets
        'L3MON4D3/LuaSnip',
        'rafamadriz/friendly-snippets',
    },
    config = function()
        -- ========================================================================
        -- CONFIGURACIÓN DE HANDLERS Y DIAGNÓSTICOS
        -- ========================================================================
        -- Bordes redondeados para ventanas flotantes
        vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
            vim.lsp.handlers.hover,
            { border = 'rounded' }
        )
        vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
            vim.lsp.handlers.signature_help,
            { border = 'rounded' }
        )

        -- Configuración de diagnósticos
        vim.diagnostic.config({
            virtual_text = {
                prefix = function(diagnostic)
                    local icons = {
                        [vim.diagnostic.severity.ERROR] = '󱚡',
                        [vim.diagnostic.severity.WARN] = '󱚝',
                        [vim.diagnostic.severity.HINT] = '󰚩',
                        [vim.diagnostic.severity.INFO] = '󱚟',
                    }
                    return icons[diagnostic.severity] or '󱚣'
                end,
            },
            severity_sort = true,
            float = {
                style = 'minimal',
                source = 'always',
                border = 'rounded',
                header = '',
                prefix = '',
            },
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = '',
                    [vim.diagnostic.severity.WARN] = '',
                    [vim.diagnostic.severity.HINT] = '󰌶',
                    [vim.diagnostic.severity.INFO] = '',
                },
            },
        })

        -- ========================================================================
        -- CAPACIDADES LSP
        -- ========================================================================
        local lspconfig_defaults = require('lspconfig').util.default_config
        lspconfig_defaults.capabilities = vim.tbl_deep_extend(
            'force',
            lspconfig_defaults.capabilities,
            require('cmp_nvim_lsp').default_capabilities()
        )

        -- ========================================================================
        -- KEYMAPS LSP (Se activan cuando LSP se adjunta)
        -- ========================================================================
        vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(event)
                -- Keymaps para LSP
                vim.keymap.set("n", "gd", vim.lsp.buf.definition,
                    { desc = "Ir a la definición", buffer = event.buf })
                vim.keymap.set("n", "K", function()
                    vim.lsp.buf.hover({ border = "single" })
                end, { desc = "Mostrar documentación", buffer = event.buf })
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, 
                    { desc = "Renombrar símbolo", buffer = event.buf })
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,
                    { desc = "Acciones de código", buffer = event.buf })

                -- Navegación adicional
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration,
                    { desc = "Ir a declaración", buffer = event.buf })
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation,
                    { desc = "Ir a implementación", buffer = event.buf })
                vim.keymap.set('n', 'go', vim.lsp.buf.type_definition,
                    { desc = "Ir a definición de tipo", buffer = event.buf })
                vim.keymap.set('n', 'gr', vim.lsp.buf.references,
                    { desc = "Buscar referencias", buffer = event.buf })
                vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help,
                    { desc = "Ayuda de firma", buffer = event.buf })
                vim.keymap.set('n', 'gl', vim.diagnostic.open_float,
                    { desc = "Mostrar diagnósticos", buffer = event.buf })
            end,
        })

        -- ========================================================================
        -- CONFIGURACIÓN DE MASON Y SERVIDORES LSP
        -- ========================================================================
        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = {
                "lua_ls",
                "ts_ls",
                "html",
                "cssls",
                "jsonls",
                "intelephense",  -- PHP
                "pyright",       -- Python
                "eslint",        -- JavaScript/TypeScript linting
                "bashls",        -- Bash
            },
            handlers = {
                -- Manejador por defecto
                function(server_name)
                    require('lspconfig')[server_name].setup({})
                end,

                -- Configuración específica para Lua
                lua_ls = function()
                    require('lspconfig').lua_ls.setup({
                        settings = {
                            Lua = {
                                runtime = { version = 'LuaJIT' },
                                diagnostics = { globals = { 'vim' } },
                                workspace = { library = { vim.env.VIMRUNTIME } },
                            },
                        },
                    })
                end,

                -- Configuración simplificada para TypeScript/JavaScript
                ts_ls = function()
                    require('lspconfig').ts_ls.setup({
                        filetypes = { 
                            "typescript", 
                            "javascript", 
                            "javascriptreact", 
                            "typescriptreact" 
                        },
                        settings = {
                            -- typescript = {
                            --     inlayHints = {
                            --         includeInlayParameterNameHints = 'all',
                            --         includeInlayFunctionParameterTypeHints = true,
                            --         includeInlayVariableTypeHints = true,
                            --     }
                            -- },
                            -- javascript = {
                            --     inlayHints = {
                            --         includeInlayParameterNameHints = 'all',
                            --         includeInlayFunctionParameterTypeHints = true,
                            --         includeInlayVariableTypeHints = true,
                            --     }
                            -- }
                        }
                    })
                end,
            },
        })

        -- ========================================================================
        -- CONFIGURACIÓN DE AUTOCOMPLETADO (CMP)
        -- ========================================================================
        local cmp = require('cmp')

        -- Cargar snippets de VSCode
        require('luasnip.loaders.from_vscode').lazy_load()

        -- Opciones de autocompletado
        vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

        cmp.setup({
            preselect = 'item',
            completion = {
                completeopt = 'menu,menuone,noinsert'
            },
            window = {
                documentation = cmp.config.window.bordered(),
            },
            sources = {
                { name = 'path' },
                { name = 'nvim_lsp' },
                { name = 'buffer', keyword_length = 3 },
                { name = 'luasnip', keyword_length = 2 },
            },
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            formatting = {
                fields = { 'abbr', 'menu', 'kind' },
                format = function(entry, item)
                    local n = entry.source.name
                    if n == 'nvim_lsp' then
                        item.menu = '[LSP]'
                    else
                        item.menu = string.format('[%s]', n)
                    end
                    return item
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<CR>'] = cmp.mapping.confirm({ select = false }),
                ['<C-f>'] = cmp.mapping.scroll_docs(5),
                ['<C-u>'] = cmp.mapping.scroll_docs(-5),
                ['<C-e>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.abort()
                    else
                        cmp.complete()
                    end
                end),
                ['<Tab>'] = cmp.mapping(function(fallback)
                    local col = vim.fn.col('.') - 1
                    if cmp.visible() then
                        cmp.select_next_item({ behavior = 'select' })
                    elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                        fallback()
                    else
                        cmp.complete()
                    end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
                ['<C-d>'] = cmp.mapping(function(fallback)
                    local luasnip = require('luasnip')
                    if luasnip.jumpable(1) then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<C-b>'] = cmp.mapping(function(fallback)
                    local luasnip = require('luasnip')
                    if luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
            }),
        })
    end
}