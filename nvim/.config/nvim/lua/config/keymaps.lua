-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local Util = require("lazyvim.util")

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

map("n", "<localleader>1", "<cmd>BufferLineGoToBuffer 1<cr>", { desc = "1st Tab" })
map("n", "<localleader>2", "<cmd>BufferLineGoToBuffer 2<cr>", { desc = "2nd Tab" })
map("n", "<localleader>3", "<cmd>BufferLineGoToBuffer 3<cr>", { desc = "3rd Tab" })
map("n", "<localleader>4", "<cmd>BufferLineGoToBuffer 4<cr>", { desc = "4th Tab" })
map("n", "<localleader>5", "<cmd>BufferLineGoToBuffer 5<cr>", { desc = "5th Tab" })
map("n", "<localleader>6", "<cmd>BufferLineGoToBuffer 6<cr>", { desc = "6th Tab" })
map("n", "<localleader>7", "<cmd>BufferLineGoToBuffer 7<cr>", { desc = "7th Tab" })
map("n", "<localleader>8", "<cmd>BufferLineGoToBuffer 8<cr>", { desc = "8th Tab" })
map("n", "<localleader>9", "<cmd>BufferLineGoToBuffer 9<cr>", { desc = "9th Tab" })
map("n", "<localleader>0", "<cmd>BufferLineGoToBuffer 0<cr>", { desc = "10th Tab" })
