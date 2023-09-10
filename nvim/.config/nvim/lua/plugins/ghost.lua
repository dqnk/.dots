return {
  {
    "subnut/nvim-ghost.nvim",
    config = function()
      vim.api.nvim_command("autocmd nvim_ghost_user_autocommands User 127.0.0.1* setfiletype python")
      vim.api.nvim_command("autocmd nvim_ghost_user_autocommands User localhost* setfiletype python")
    end,
  },
}
