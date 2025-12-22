-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local wk = require("which-key")
local Terminal = require("toggleterm.terminal").Terminal

-- groups custom keymaps
wk.add({
  { "<leader>G", group = "+Github Octo" },
  { "<leader>T", group = "+Tools" },
  { "<leader>t", group = "+terminal" },
  { "<leader>Tn", group = "+Node" },
  { "<leader>Tj", group = "+Java" },
  { "<leader>O", group = "+Oil" },
  { "<leader>n", group = "+notifications" },
  { "<leader>m", group = "+multicursor" },
})

vim.keymap.set({ "n", "v" }, "<leader>mp", "<Plug>(VM-Add-Cursor-At-Pos)", { desc = "Add Cursor At Pos" })
vim.keymap.set({ "n" }, "<leader>mt", "<Plug>(VM-Toggle-Mappings)", { desc = "Toggle Mapping" })

-- nest
local nestApp = Terminal:new({
  cmd = "npm run start:dev",
  direction = "horizontal",
  float_opts = {
    border = "double",
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
  end,
  -- function to run on closing the terminal
  on_close = function(term)
    vim.cmd("startinsert!")
  end,
})

function _nest_toggle()
  nestApp:toggle()
end

vim.api.nvim_set_keymap(
  "n",
  "<leader>Tnn",
  "<cmd>lua _nest_toggle()<CR>",
  { noremap = true, silent = true, desc = "Nest Run App" }
)

-- java
local javaApp = Terminal:new({
  cmd = "mvn spring-boot:run",
  direction = "horizontal",
  float_opts = {
    border = "double",
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
  end,
  -- function to run on closing the terminal
  on_close = function(term)
    vim.cmd("startinsert!")
  end,
})

function _java_toggle()
  javaApp:toggle()
end

vim.api.nvim_set_keymap(
  "n",
  "<leader>Tjn",
  "<cmd>lua _java_toggle()<CR>",
  { noremap = true, silent = true, desc = "Java SpringBoot Run App" }
)

vim.keymap.set({ "n", "v" }, "<leader>mp", "<Plug>(VM-Add-Cursor-At-Pos)", { desc = "Add Cursor At Pos" })
vim.keymap.set({ "n" }, "<leader>mt", "<Plug>(VM-Toggle-Mappings)", { desc = "Toggle Mapping" })

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

vim.api.nvim_set_keymap("n", "<C-s>", ":lua SaveFile()<CR><esc>", { noremap = true, silent = true })

-- Custom save function
function SaveFile()
  -- Check if a buffer with a file is open
  if vim.fn.empty(vim.fn.expand("%:t")) == 1 then
    vim.notify("💣 No file to save", vim.log.levels.WARN)
    return
  end

  local filename = vim.fn.expand("%:t") -- Get only the filename
  local success, err = pcall(function()
    vim.cmd("silent! write") -- Try to save the file without showing the default message
  end)

  if success then
    vim.notify(filename .. " 💣 Saved!") -- Show only the custom message if successful
  else
    vim.notify("Error: " .. err, vim.log.levels.ERROR) -- Show the error message if it fails
  end
end
