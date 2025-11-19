return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    ensure_installed = { "lua", "vim", "html", "css", "javascript", "typescript", "java", "sql", "sql" }, -- Add more languages here
    highlight = { enable = true },
    sync_install = false,
    highlight = {
      enable = true,
      additional_vim_regex_hightlighting = false,
    }
  },
}
