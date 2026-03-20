return {

  -- the opts function can also be used to change the default opts:
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, {
        function()
          return "😄"
        end,
      })
    end,
  },

  -- or you can return new options to override all the defaults
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    requires = { "nvim-tree/nvim-web-devicons", opt = true }, -- Optional dependency for icons
    opts = function()
      return {
        --[[add your custom lualine config here]]
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
        },
      }
    end,
  },
}
