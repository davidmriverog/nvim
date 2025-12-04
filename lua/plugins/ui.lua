local mode = {
  "mode",
  fmt = function(s)
    local mode_map = {
      ["NORMAL"] = "N",
      ["O-PENDING"] = "N?",
      ["INSERT"] = "I",
      ["VISUAL"] = "V",
      ["V-BLOCK"] = "VB",
      ["V-LINE"] = "VL",
      ["V-REPLACE"] = "VR",
      ["REPLACE"] = "R",
      ["COMMAND"] = "!",
      ["SHELL"] = "SH",
      ["TERMINAL"] = "T",
      ["EX"] = "X",
      ["S-BLOCK"] = "SB",
      ["S-LINE"] = "SL",
      ["SELECT"] = "S",
      ["CONFIRM"] = "Y?",
      ["MORE"] = "M",
    }
    return mode_map[s] or s
  end,
}

local function codecompanion_adapter_name()
  local chat = require("codecompanion").buf_get_chat(vim.api.nvim_get_current_buf())
  if not chat then
    return nil
  end

  return " " .. chat.adapter.formatted_name
end

local function codecompanion_current_model_name()
  local chat = require("codecompanion").buf_get_chat(vim.api.nvim_get_current_buf())
  if not chat then
    return nil
  end

  return chat.settings.model
end
-- This file contains the configuration for various UI-related plugins in Neovim.
return {
  -- Plugin: folke/todo-comments.nvim
  -- URL: https://github.com/folke/todo-comments.nvim
  -- Description: Plugin to highlight and search for TODO, FIX, HACK, etc. comments in your code.
  -- IMPORTANT: using version "*" to fix a bug
  { "folke/todo-comments.nvim", version = "*" },

  -- Plugin: folke/which-key.nvim
  -- URL: https://github.com/folke/which-key.nvim
  -- Description: Plugin to show a popup with available keybindings.
  -- IMPORTANT: using event "VeryLazy" to optimize loading time
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "classic",
      win = { border = "single" },
    },
  },

  -- Plugin: nvim-docs-view
  -- URL: https://github.com/amrbashir/nvim-docs-view
  -- Description: A Neovim plugin for viewing documentation.
  {
    "amrbashir/nvim-docs-view",
    lazy = true, -- Load this plugin lazily
    cmd = "DocsViewToggle", -- Command to toggle the documentation view
    opts = {
      position = "right", -- Position the documentation view on the right
      width = 60, -- Set the width of the documentation view
    },
  },

  -- Plugin: lualine.nvim
  -- URL: https://github.com/nvim-lualine/lualine.nvim
  -- Description: A blazing fast and easy to configure Neovim statusline plugin.
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy", -- Load this plugin on the 'VeryLazy' event
    requires = { "nvim-tree/nvim-web-devicons", opt = true }, -- Optional dependency for icons
    opts = {
      options = {
        theme = "auto", -- Set the theme for lualine
        icons_enabled = true, -- Enable icons in the statusline
      },
      sections = {
        lualine_a = {
          {
            "mode", -- Display the current mode
            icon = "💣", -- Set the icon for the mode
          },
        },
      },
      extensions = {
        "quickfix",
        {
          filetypes = { "oil" },
          sections = {
            lualine_a = {
              mode,
            },
            lualine_b = {
              function()
                local ok, oil = pcall(require, "oil")
                if not ok then
                  return ""
                end

                ---@diagnostic disable-next-line: param-type-mismatch
                local path = vim.fn.fnamemodify(oil.get_current_dir(), ":~")
                return path .. " %m"
              end,
            },
          },
        },
        {
          filetypes = { "codecompanion" },
          sections = {
            lualine_a = {
              mode,
            },
            lualine_b = {
              codecompanion_adapter_name,
            },
            lualine_c = {
              codecompanion_current_model_name,
            },
            lualine_x = {},
            lualine_y = {
              "progress",
            },
            lualine_z = {
              "location",
            },
          },
          inactive_sections = {
            lualine_a = {},
            lualine_b = {
              codecompanion_adapter_name,
            },
            lualine_c = {},
            lualine_x = {},
            lualine_y = {
              "progress",
            },
            lualine_z = {},
          },
        },
      },
    },
  },

  -- Plugin: incline.nvim
  -- URL: https://github.com/b0o/incline.nvim
  -- Description: A Neovim plugin for showing the current filename in a floating window.
  {
    "b0o/incline.nvim",
    event = "BufReadPre", -- Load this plugin before reading a buffer
    priority = 1200, -- Set the priority for loading this plugin
    config = function()
      require("incline").setup({
        window = { margin = { vertical = 0, horizontal = 1 } }, -- Set the window margin
        hide = {
          cursorline = true, -- Hide the incline window when the cursorline is active
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t") -- Get the filename
          if vim.bo[props.buf].modified then
            filename = "[+] " .. filename -- Indicate if the file is modified
          end

          local icon, color = require("nvim-web-devicons").get_icon_color(filename) -- Get the icon and color for the file
          return { { icon, guifg = color }, { " " }, { filename } } -- Return the rendered content
        end,
      })
    end,
  },

  -- Plugin: zen-mode.nvim
  -- URL: https://github.com/folke/zen-mode.nvim
  -- Description: A Neovim plugin for distraction-free coding.
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode", -- Command to toggle Zen Mode
    opts = {
      plugins = {
        gitsigns = true, -- Enable gitsigns integration
        tmux = true, -- Enable tmux integration
        kitty = { enabled = false, font = "+2" }, -- Disable kitty integration and set font size
        twilight = { enabled = true }, -- Enable twilight integration
      },
    },
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } }, -- Keybinding to toggle Zen Mode
  },

  -- Plugin: snacks.nvim
  -- URL: https://github.com/folke/snacks.nvim/tree/main
  -- Description: A Neovim plugin for creating a customizable dashboard.
  {
    "folke/snacks.nvim",
    config = function(_, opts)
    require("snacks").setup(opts)

    Snacks.toggle.new({
      id = "ufo",
      name = "Enable/Disable ufo",
      get = function()
        return require("ufo").inspect()
      end,
      set = function(state)
        if state == nil then
          require("noice").enable()
          require("ufo").enable()
          vim.o.foldenable = true
          vim.o.foldcolumn = "1"
        else
          require("noice").disable()
          require("ufo").disable()
          vim.o.foldenable = false
          vim.o.foldcolumn = "0"
        end
      end,
    })
  end,
    init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "OilActionsPost",
      callback = function(event)
        if event.data.actions.type == "move" then
          Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
        end
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end

        -- Override print to use snacks for `:=` command
        if vim.fn.has("nvim-0.11") == 1 then
          vim._print = function(_, ...)
            dd(...)
          end
        else
          vim.print = _G.dd
        end

        -- Create some toggle mappings
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map(
          "<leader>uc")
        Snacks.toggle.treesitter():map("<leader>uT")
        Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle.indent():map("<leader>ug")
        Snacks.toggle.dim():map("<leader>uD")

        -- vim.cmd(":lua Snacks.explorer()");
      end,
    })
  end,
    opts = {
      bigfile = { enabled = true },
      notifier = {},
      image = {},
      picker = { enabled = true },
      -- picker = {
      --   enabled=true,
      --   exclude = {
      --     ".git",
      --     "node_modules",
      --   },
      --   matcher = {
      --     fuzzy = true,
      --     smartcase = true,
      --     ignorecase = true,
      --     filename_bonus = true,
      --   },
      --   sources = {},
      -- },
      explorer = { enabled = true, trash = false },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      quickfile = { enabled = true },
      scope = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      rename = { enabled = true },
      dashboard = {
        sections = {
          { section = "header" },
          { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
          { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          { section = "startup" },
        },
        preset = {
          header = [[
          ██████╗  ██████╗ ███╗   ███╗██████╗
          ██╔══██╗██╔═══██╗████╗ ████║██╔══██╗
          ██████╔╝██║   ██║██╔████╔██║██████╔╝
          ██╔══██╗██║   ██║██║╚██╔╝██║██╔══██╗
          ██████╔╝╚██████╔╝██║ ╚═╝ ██║██████╔╝
          ╚═════╝  ╚═════╝ ╚═╝     ╚═╝╚═════╝
        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀
        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀
        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠤⣀⠀⢠⡀⣿⣰⢀⣠⠴⠋⠀
        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣀⣙⣳⣿⣿⣿⣿⣅⣀⡀⠀
        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⢠⣄⣤⣄⣠⣶⣿⡭⣙⣷⣿⣿⣿⣯⡉⠉⠁
        ⠀⠀⠀⠀⢀⣤⡶⠚⣿⣿⢡⣷⡻⣿⡺⡿⣻⣄⠀⣰⠟⢹⡟⣿⠀⠉⠀⠀
        ⠀⠀⢀⡴⠛⠙⣶⣾⣿⣿⡘⢿⣿⣷⣯⣟⣛⡟⠰⠁⠀⢸⡇⠘⡆⠀⠀⠀
        ⠀⢠⠏⠀⠀⣰⣿⣿⣿⣿⣿⣶⣍⣛⠻⠿⠟⣼⡆⠀⠀⢸⠃⠀⠀⠀⠀⠀
        ⠀⣿⣤⣤⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡀⠀⠘⠂⠀⠀⠀⠀⠀
        ⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀
        ⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇⠀⠀⠀⠀⠀⠀⠀⠀
        ⠀⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀
        ⠀⠀⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀
        ⠀⠀⠀⠈⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
        ⠀⠀⠀⠀⠀⠀⠉⠙⠛⠛⠛⠛⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
]],
          -- stylua: ignore
          ---@type snacks.dashboard.Item[]
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
    },
  },
}
