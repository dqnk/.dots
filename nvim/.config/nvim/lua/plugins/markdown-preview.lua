return {
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    keys = {
      {
        "<localleader>pl",
        "<cmd>MarkdownPreview<cr>",
        desc = "Markdown Preview",
      },
    },
    config = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
}
