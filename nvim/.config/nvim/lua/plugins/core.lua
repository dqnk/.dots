return {
  { "dqnk/molokai", branch = "lua-rewrite" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "molokai",
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = true },
    },
  },
}
