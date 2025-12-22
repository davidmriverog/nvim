return {
  "stevearc/oil.nvim",
  -- Make sure it's not lazy-loaded if you want it to replace netrw by default
  lazy = false, 
  -- Specify dependencies (optional but good practice)
  dependencies = { "nvim-tree/nvim-web-devicons" }, 
  -- Configuration for oil.nvim
  opts = {
    -- Set this to true to make oil the default file explorer for directory buffers
    default_file_explorer = true, 
    view_options = {
      show_hidden = true, -- Show hidden files
    },
    -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
    keymaps = {
      ["g?"] = "actions.show_help",
      ["<CR>"] = "actions.select",
      ["<C-s>"] = { "actions.select", opts = { vertical = true }, desc = "Open in vertical split" },
      ["<C-v>"] = { "actions.select", opts = { horizontal = true }, desc = "Open in horizontal split" },
      ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open in new tab" },
      ["<C-p>"] = "actions.preview",
      ["<C-c>"] = "actions.close",
      ["<C-l>"] = "actions.refresh",
      ["-"] = "actions.parent",
      ["_"] = "actions.open_cwd",
      ["`"] = "actions.cd",
      ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
      ["gs"] = "actions.change_sort",
      ["gx"] = "actions.open_external",
      ["g."] = "actions.toggle_hidden",
      ["g\\"] = "actions.toggle_trash",
      -- Quick quit
      ["q"] = "actions.close",
    },
    -- Set to false to disable all of the above keymaps
    use_default_keymaps = false,
    view_options = {
      -- Show files and directories that start with "." by default
      show_hidden = true,
      -- This function defines what is considered a "hidden" file
      is_hidden_file = function(name, bufnr)
        return vim.startswith(name, ".")
      end,
      -- This function defines what will never be shown, even when `show_hidden` is set
      is_always_hidden = function(name, bufnr)
        return name == ".." or name == ".git"
      end,
      -- Natural sort order for files and directories
      natural_order = true,
      case_insensitive = false,
      sort = {
        -- sort order can be "asc" or "desc"
        -- see :help oil-columns to see which columns are sortable
        { "type", "asc" },
        { "name", "asc" },
      },
    },
    view_options = {
      -- Show files and directories that start with "." by default
      show_hidden = true,
      -- This function defines what is considered a "hidden" file
      is_hidden_file = function(name, bufnr)
        return vim.startswith(name, ".")
      end,
      -- This function defines what will never be shown, even when `show_hidden` is set
      is_always_hidden = function(name, bufnr)
        return name == ".." or name == ".git"
      end,
      -- Natural sort order for files and directories
      natural_order = true,
      case_insensitive = false,
      sort = {
        -- sort order can be "asc" or "desc"
        -- see :help oil-columns to see which columns are sortable
        { "type", "asc" },
        { "name", "asc" },
      },
    },

    -- Configuration for the floating window in oil.open_float
    float = {
      -- Padding around the floating window
      padding = 2,
      max_width = 100,
      max_height = 30,
      border = "rounded",
      win_options = {
        winblend = 0,
      },
      -- preview_split: Split direction: "auto", "left", "right", "above", "below".
      preview_split = "auto",
      -- This is the config that will be passed to nvim_open_win.
      -- Change values here to customize the layout
      override = function(conf)
        return conf
      end,
    },

    -- Configuration for the actions floating preview window
    preview = {
      -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
      -- min_width and max_width can be a single value or a list of mixed integer/float types.
      max_width = 0.9,
      -- min_width = {40, 0.4} means "at least 40 columns, or at least 40% of total"
      min_width = { 40, 0.4 },
      -- optionally define an integer/float for the exact width of the preview window
      width = nil,
      -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
      max_height = 0.9,
      min_height = { 5, 0.1 },
      -- optionally define an integer/float for the exact height of the preview window
      height = nil,
      border = "rounded",
      win_options = {
        winblend = 0,
      },
      -- Whether the preview window is automatically updated when the cursor is moved
      update_on_cursor_moved = true,
    },

    -- Configuration for the floating progress window
    progress = {
      max_width = 0.9,
      min_width = { 40, 0.4 },
      width = nil,
      max_height = { 10, 0.9 },
      min_height = { 5, 0.1 },
      height = nil,
      border = "rounded",
      minimized_border = "none",
      win_options = {
        winblend = 0,
      },
    },

    -- Configuration for the floating SSH window
    ssh = {
      border = "rounded",
    },
  },
  -- Keymaps for opening oil
  keys = {
    -- { "<leader>e", "<cmd>Oil<cr>", desc = "Open File Explorer" },
    { "<leader>fe", "<cmd>Oil<cr>", desc = "Open File Explorer (alt)" },
    { "<leader>f.", "<cmd>Oil<cr>", desc = "Open Current Dir" },
    -- Example for a floating window (optional)
    { "<leader>fo", "<cmd>Oil --float<cr>", desc = "Open Floating File Explorer" }, 
  },
}