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
    -- Bordes redondeados para las ventanas flotantes de documentación y firmas
    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
      vim.lsp.handlers.hover,
      { border = 'rounded' }
    )
    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
      vim.lsp.handlers.signature_help,
      { border = 'rounded' }
    )

    -- Configuración de la interfaz de errores y advertencias
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
          [vim.diagnostic.severity.ERROR] = '',
          [vim.diagnostic.severity.WARN] = '',
          [vim.diagnostic.severity.HINT] = '󰌶',
          [vim.diagnostic.severity.INFO] = '',
        },
      },
    })

    -- Agregar capacidades de cmp_nvim_lsp antes de configurar cualquier LSP
    local lspconfig_defaults = require('lspconfig').util.default_config
    lspconfig_defaults.capabilities = vim.tbl_deep_extend(
      'force',
      lspconfig_defaults.capabilities,
      require('cmp_nvim_lsp').default_capabilities()
    )

    -- Configuración de autocmd cuando un LSP se adjunta a un buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(event)
        local opts = { buffer = event.buf }

        -- Keymaps para LSP
        vim.keymap.set("n", "gd", vim.lsp.buf.definition,
          { desc = "Ir a la definición del símbolo", buffer = event.buf })
        vim.keymap.set("n", "K", function()
          vim.lsp.buf.hover({ border = "single" })
        end, { desc = "Mostrar documentación flotante", buffer = event.buf })
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Renombrar símbolo", buffer = event.buf })
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,
          { desc = "Mostrar acciones del código", buffer = event.buf })
        -- vim.keymap.set("n", "<leader>f", function()
        --     vim.lsp.buf.format { async = true }
        -- end, { desc = "Formatear archivo manualmente", buffer = event.buf })

        -- Otros keymaps útiles
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>',
          { desc = "Ir a declaración del símbolo", buffer = event.buf })
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>',
          { desc = "Ir a implementación del símbolo", buffer = event.buf })
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>',
          { desc = "Ir a definición de tipo", buffer = event.buf })
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>',
          { desc = "Buscar referencias del símbolo", buffer = event.buf })
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>',
          { desc = "Ayuda con la firma de función", buffer = event.buf })
        vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>',
          { desc = "Mostrar errores y advertencias flotantes", buffer = event.buf })
      end,
    })

    -- Configuración de Mason y mason-lspconfig
    require('mason').setup({})
    require('mason-lspconfig').setup({
      ensure_installed = {
        "lua_ls",
        "ts_ls",
        "html",
        "cssls",
        "jsonls",
        "intelephense",
        "pyright",
        "eslint",
        "php",
        "bashls", --Bash
      },
      handlers = {
        -- Manejador por defecto para todos los servidores sin configuración específica
        function(server_name)
          require('lspconfig')[server_name].setup({})
        end,

        -- Configuración personalizada para lua_ls
        lua_ls = function()
          require('lspconfig').lua_ls.setup({
            settings = {
              Lua = {
                runtime = {
                  version = 'LuaJIT',
                },
                diagnostics = {
                  globals = { 'vim' },
                },
                workspace = {
                  library = { vim.env.VIMRUNTIME },
                },
              },
            },
          })
        end,
        -- Configuración para TypeScript con soporte para Vue
        ts_ls = function()
          local mason_registry = require("mason-registry")
          local vue_language_server = mason_registry.get_package("vue-language-server"):get_install_path()
              .. "/node_modules/@vue/language-server"
          require('lspconfig').ts_ls.setup({
            init_options = {
              plugins = {
                {
                  name = "@vue/typescript-plugin",
                  location = vue_language_server,
                  languages = { "vue" },
                }
              }
            },
            filetypes = { "typescript", "javascript", "vue" }
          })
        end,
        -- Configuración para Volar (Vue Language Server)
        -- volar = function()
        --     require('lspconfig').volar.setup({
        --         filetypes = { "vue" },
        --         init_options = {
        --             vue = {
        --                 hybridMode = false,
        --             },
        --         },
        --     })
        -- end,
      },
    })

    local cmp = require('cmp')

    -- Cargar fragmentos de código de VSCode
    require('luasnip.loaders.from_vscode').lazy_load()

    -- Opciones para autocompletado
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
        { name = 'buffer',  keyword_length = 3 },
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
        ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Confirmar selección

        ['<C-f>'] = cmp.mapping.scroll_docs(5),             -- Desplazar documentación hacia abajo
        ['<C-u>'] = cmp.mapping.scroll_docs(-5),            -- Desplazar documentación hacia arriba

        ['<C-e>'] = cmp.mapping(function(fallback)          -- Mostrar u ocultar el menú de autocompletado
          if cmp.visible() then
            cmp.abort()
          else
            cmp.complete()
          end
        end),

        ['<Tab>'] = cmp.mapping(function(fallback) -- Siguiente sugerencia o activar completado
          local col = vim.fn.col('.') - 1
          if cmp.visible() then
            cmp.select_next_item({ behavior = 'select' })
          elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
            fallback()
          else
            cmp.complete()
          end
        end, { 'i', 's' }),

        ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = 'select' }), -- Sugerencia anterior

        ['<C-d>'] = cmp.mapping(function(fallback)                           -- Siguiente marcador de snippet
          local luasnip = require('luasnip')
          if luasnip.jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { 'i', 's' }),

        ['<C-b>'] = cmp.mapping(function(fallback) -- Marcador anterior de snippet
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
