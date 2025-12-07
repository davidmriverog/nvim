-- This file contains custom key mappings for Neovim.

-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local wk = require("which-key")

-- groups custom keymaps
wk.add({
  { "<leader>G", group = "+Github Octo" },
  { "<leader>J", group = "+Java" },
  { "<leader>T", group = "+Tools" },
  { "<leader>t", group = "+terminal" },
  { "<leader>Tn", group = "+NodeJs" },
  { "<leader>n", group = "+notifications" },
  { "<leader>m", group = "+multicursor" },
  {
    "<leader>Tnn",
    function()
      vim.cmd(':TermExec cmd="npm run start:dev"')
    end,
    desc = "NestJS Run App",
    mode = "n",
  },
  {
    "<leader>Tnd",
    function()
      vim.cmd(':TermExec cmd="npm run start:dev -- --inspect-brk"')
    end,
    desc = "NestJS Run Debug App",
    mode = "n",
  },
})

-- Screen Keys
vim.keymap.set({ "n" }, "<leader>uk", "<cmd>Screenkey<CR>")

-- Github
vim.keymap.set("n", "<leader>Gp", function() 
  if pcall(require, "snacks") then
    require("snacks").picker.gh_pr()
  end
end, { desc = "Github Pull Requests (open)" })

-- Toggle terminal
vim.keymap.set("n", "<leader>tt", function() 
  if pcall(require, "snacks") then
    require("snacks").terminal()
  end
end, { desc = "Toggle Terminal" })

vim.keymap.set("n", "<leader>GP", function() Snacks.picker.gh_pr({ state = "all" }) end, { desc = "Github Pull Requests (all)" })

----- OBSIDIAN -----
vim.keymap.set("n", "<leader>oc", "<cmd>ObsidianCheck<CR>", { desc = "Obsidian Check Checkbox" })
vim.keymap.set("n", "<leader>ot", "<cmd>ObsidianTemplate<CR>", { desc = "Insert Obsidian Template" })
vim.keymap.set("n", "<leader>oo", "<cmd>Obsidian Open<CR>", { desc = "Open in Obsidian App" })
vim.keymap.set("n", "<leader>ob", "<cmd>ObsidianBacklinks<CR>", { desc = "Show ObsidianBacklinks" })
vim.keymap.set("n", "<leader>ol", "<cmd>ObsidianLinks<CR>", { desc = "Show ObsidianLinks" })
vim.keymap.set("n", "<leader>on", "<cmd>ObsidianNew<CR>", { desc = "Create New Note" })
vim.keymap.set("n", "<leader>os", "<cmd>ObsidianSearch<CR>", { desc = "Search Obsidian" })
vim.keymap.set("n", "<leader>oq", "<cmd>ObsidianQuickSwitch<CR>", { desc = "Quick Switch" })
-- vim.keymap.set("n", "<leader>e", "<Cmd>Neotree<CR>")

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


----- OIL -----
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Delete all buffers but the current one
vim.keymap.set(
  "n",
  "<leader>bq",
  '<Esc>:%bdelete|edit #|normal`"<Return>',
  { desc = "Delete other buffers but the current one" }
)


-- Redefine Ctrl+s to save with the custom function
vim.api.nvim_set_keymap("n", "<C-s>", ":lua SaveFile()<CR><esc>", { noremap = true, silent = true })

-- Grep keybinding for visual mode - search selected text
vim.keymap.set("v", "<leader>sg", function()
  -- Get the selected text
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local lines = vim.fn.getline(start_pos[2], end_pos[2])

  if #lines == 0 then
    return
  end

  -- Handle single line selection
  if #lines == 1 then
    lines[1] = string.sub(lines[1], start_pos[3], end_pos[3])
  else
    -- Handle multi-line selection
    lines[1] = string.sub(lines[1], start_pos[3])
    lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])
  end

  local selected_text = table.concat(lines, "\n")

  -- Escape special characters for grep
  selected_text = vim.fn.escape(selected_text, "\\.*[]^$()+?{}")

  -- Use the selected text for grep
  if pcall(require, "snacks") then
    require("snacks").picker.grep({ search = selected_text })
  elseif pcall(require, "fzf-lua") then
    require("fzf-lua").live_grep({ search = selected_text })
  else
    vim.notify("No grep picker available", vim.log.levels.ERROR)
  end
end, { desc = "Grep Selected Text" })

-- Grep keybinding for visual mode with G - search selected text at root level
vim.keymap.set("v", "<leader>sG", function()
  -- Get git root or fallback to cwd
  local git_root = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null"):gsub("\n", "")
  local root = vim.v.shell_error == 0 and git_root ~= "" and git_root or vim.fn.getcwd()

  -- Get the selected text
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local lines = vim.fn.getline(start_pos[2], end_pos[2])

  if #lines == 0 then
    return
  end

  -- Handle single line selection
  if #lines == 1 then
    lines[1] = string.sub(lines[1], start_pos[3], end_pos[3])
  else
    -- Handle multi-line selection
    lines[1] = string.sub(lines[1], start_pos[3])
    lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])
  end

  local selected_text = table.concat(lines, "\n")

  -- Escape special characters for grep
  selected_text = vim.fn.escape(selected_text, "\\.*[]^$()+?{}")

  -- Use the selected text for grep at root level
  if pcall(require, "snacks") then
    require("snacks").picker.grep({ search = selected_text, cwd = root })
  elseif pcall(require, "fzf-lua") then
    require("fzf-lua").live_grep({ search = selected_text, cwd = root })
  else
    vim.notify("No grep picker available", vim.log.levels.ERROR)
  end
end, { desc = "Grep Selected Text (Root Dir)" })

-- Delete all marks
vim.keymap.set("n", "<leader>md", function()
  vim.cmd("delmarks!")
  vim.cmd("delmarks A-Z0-9")
  vim.notify("All marks deleted")
end, { desc = "Delete all marks" })

-- Custom save function
function SaveFile()
  -- Check if a buffer with a file is open
  if vim.fn.empty(vim.fn.expand("%:t")) == 1 then
    vim.notify("No file to save", vim.log.levels.WARN)
    return
  end

  local filename = vim.fn.expand("%:t") -- Get only the filename
  local success, err = pcall(function()
    vim.cmd("silent! write") -- Try to save the file without showing the default message
  end)

  if success then
    vim.notify(filename .. " Saved!") -- Show only the custom message if successful
  else
    vim.notify("Error: " .. err, vim.log.levels.ERROR) -- Show the error message if it fails
  end
end
