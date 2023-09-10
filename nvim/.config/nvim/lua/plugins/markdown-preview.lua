return {
  {
    "iamcco/markdown-preview.nvim",
    keys = {
      {
        "<localleader>ll",
        "<cmd>MarkdownPreview<cr>",
        desc = "Markdown Preview",
      },
    },
    ft = "markdown",
    config = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
}
