-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
  group = vim.api.nvim_create_augroup("FixInlayHints", { clear = true }),
  callback = function(args)
    -- Check if inlay hints are active before forcing a refresh
    if vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf }) then
      -- Temporarily toggle to clear the stale cache positions
      vim.lsp.inlay_hint.enable(false, { bufnr = args.buf })
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end
  end,
})
