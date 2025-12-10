return {
    {
        "akinsho/toggleterm.nvim",
        version = "*", -- use "*" for the latest stable release
        config = function()
        require("toggleterm").setup({
            -- your configuration options go here
            size = 12,
            open_mapping = [[<leader>tt]], -- Set a key mapping to toggle the terminal
            direction = "horizontal",
        })
        end,
        -- Optional: Add keymaps directly in the plugin spec
        keys = {
        { [[<leader>tt]], "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
        },
    },
}