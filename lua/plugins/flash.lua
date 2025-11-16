return {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
   config = function ()
        vim.api.nvim_set_hl(0, "FlashBackdrop", {
            fg = "#7aa2f7",
            bg = "#1a1b26",
            blend = 30,
        })
        require("flash").setup({})
   end,
    -- stylua: ignore
    keys = {
        { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
        { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
        { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
        { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
}
