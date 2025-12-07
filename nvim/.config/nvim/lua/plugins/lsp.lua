return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = true },
    servers = {
      racket_langserver = {
        cmd = { "racket", "--lib", "racket-langserver", "--", "--stdio" },
        filetypes = { "racket", "scheme" },
      },
    },
  },
}
