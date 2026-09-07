return {
  -- add pyright to lspconfig
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pyright = {},
      },
    },
  },

  -- add tsserver and setup with typescript.nvim instead of lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      init = function()
        require("lazyvim.util").lsp.on_attach(function(_, buffer)
          -- stylua: ignore
          vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
          vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
        end)
      end,
    },
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- tsserver will be automatically installed with mason and loaded with lspconfig
        tsserver = {},
        eslint = {
          settings = {
            workingDirectories = { mode = "auto" },
          },
        },
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        eslint = function()
          local function on_attach(client, bufnr)
            if client.name == "eslint" then
              vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                command = "EslintFixAll",
              })
            end
          end
          require("lazyvim.util").lsp.on_attach(on_attach)
        end,
        -- example to setup with typescript.nvim
        tsserver = function(_, opts)
          require("typescript").setup({ server = opts })
          return true
        end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },

    -- example using `opts` for defining servers
    opts = {
      servers = {
        lua_ls = {},
      },
    },
    config = function(_, opts)
      local lspconfig = require("lspconfig")
      for server, config in pairs(opts.servers) do
        -- passing config.capabilities to blink.cmp merges with the capabilities in your
        -- `opts[server].capabilities, if you've defined it
        config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        angularls = {
          -- Ensure Mason installs the correct version (v20+)
          -- You can pin it: `mason = { ensure_installed = { "angular-language-server@20.3.0" } }` if needed
          cmd = {
            "ngserver",
            "--stdio",
            "--tsProbeLocations",
            "", -- will be filled dynamically
            "--ngProbeLocations",
            "", -- will be filled dynamically
          },
          on_new_config = function(new_config, root_dir)
            local project_root = root_dir or vim.fn.getcwd()
            local node_modules = project_root .. "/node_modules"

            new_config.cmd[4] = node_modules
            new_config.cmd[6] = node_modules

            -- Optional: Enable Ivy if your project uses it
            -- new_config.init_options = { experimental = { ivy = true } }
          end,

          -- Better root detection (especially for monorepos)
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern("angular.json", "package.json")(fname)
          end,

          -- Filetypes to activate on
          filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx" },
        },
      },
      setup = {
        angularls = function()
          return true
        end,
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        emmet_language_server = {
          filetypes = { "html", "css", "javascriptreact", "typescriptreact", "sass", "scss", "less" },
        },
      },
    },
  },

  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
        "angular",
      },
    },
  },

  -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
  -- would overwrite `ensure_installed` with the new value.
  -- If you'd rather extend the default config, use the code below instead:
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "tsx",
        "typescript",
      })
    end,
  },
}
