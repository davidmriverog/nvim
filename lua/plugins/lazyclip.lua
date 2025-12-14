return {
  "atiladefreitas/lazyclip",
  lazy = false,
  config = function()
    require("lazyclip").setup({
      -- your custom config here (optional)
      max_history = 1000, -- Maximum number of items to keep in history
    })
  end,
  keys = {
    { "C-c", desc = "Open Clipboard Manager" },
  },
  -- Optional: Load plugin when yanking text
  -- event = { "TextYankPost" },
}
