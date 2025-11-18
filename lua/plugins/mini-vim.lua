return {
  -- mini.pairs: inserción automática de paréntesis, llaves, comillas, etc.
  {
    "echasnovski/mini.pairs",
    version = false,
    config = function()
      require("mini.pairs").setup()
    end,
  },
}

