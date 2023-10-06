-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.cmd([[autocmd BufEnter * set wrap]])

vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.tex",
  command = "0r ~/.config/nvim/skeletons/template.tex",
})

vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.cpp",
  command = "0r ~/.config/nvim/skeletons/template.cpp",
})
