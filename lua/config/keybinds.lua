-- ============================================================================
-- CONFIGURACIÓN DE TECLAS GLOBALES
-- ============================================================================
-- NOTA: Las teclas líder se configuran en config/lazy.lua antes de cargar plugins

-- Deshabilitar netrw (usamos Oil.nvim)
--vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

local wk = require("which-key")

-- groups custom keymaps
wk.add({
  { "<leader>J", group = "+Java" },
  { "<leader>T", group = "+Tools" },
  {
    "<leader>Tn",
    function()
      vim.cmd(':TermExec cmd="npm run start:dev"')
    end,
    desc = "NestJS Run App",
    mode = "n",
  },
  { "<leader>c", group = "+code" },
  { "<leader>f", group = "+find" },
  { "<leader>h", group = "+harpoon" },
  { "<leader>g", group = "+git" },
  { "<leader>G", group = "+github" },
  { "g",         group = "+goto" },
  { "<leader>u", group = "+utils" },
  { "<leader>s", group = "+search" },
  { "<leader>s", group = "+grep" },
  { "<leader>b", group = "+buffers" },
  { "<leader>o", group = "neoclip" },
  { "<leader>r", group = "+rip sub" },
})

-- override keymaps

local opts = { noremap = true, silent = true }
-- Normal-mode commands
vim.keymap.set("n", "<A-Down>", ":MoveLine 1<CR>", opts)
vim.keymap.set("n", "<A-Up>", ":MoveLine -1<CR>", opts)
vim.keymap.set("n", "<A-S-Left>", ":MoveWord -1<CR>", opts)
vim.keymap.set("n", "<A-S-Right>", ":MoveWord 1<CR>", opts)

-- Visual-mode commands
vim.keymap.set("x", "<A-Down>", ":MoveBlock 1<CR>", opts)
vim.keymap.set("x", "<A-Up>", ":MoveBlock -1<CR>", opts)
vim.keymap.set("v", "<A-Left>", ":MoveHBlock -1<CR>", opts)
vim.keymap.set("v", "<A-Right>", ":MoveHBlock 1<CR>", opts)

vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- Salir de Neovim con validación inteligente
vim.keymap.set("n", "<leader>q", function()
  local function show_error()
    vim.notify("⚠️ No se puede salir. Hay cambios sin guardar en los buffers:\n" ..
      "• Usa ':wa' para guardar todo y luego ':qa'\n" ..
      "• Usa ':qa!' para descartar todos los cambios",
      vim.log.levels.ERROR, {
        title = "Acción requerida",
        timeout = 5000,
        icon = "",
        on_open = function(win)
          local buf = vim.api.nvim_win_get_buf(win)
          vim.api.nvim_buf_set_option(buf, 'filetype', 'markdown')
        end,
      })
  end

  -- Intenta salir silenciosamente para validar
  local success, err = pcall(vim.cmd, "qa")

  if not success then
    -- Analiza el mensaje de error para determinar la causa
    if string.find(err, "E37") then -- Código de error para buffers no guardados
      show_error()
    else
      -- Para otros tipos de errores
      vim.notify("❌ Error al intentar salir: " .. err, vim.log.levels.ERROR)
    end
  end
end, opts, { desc = "Salir de nvim" })
