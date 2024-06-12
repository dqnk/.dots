return {
  {
    "nvim-orgmode/orgmode",
    ft = { "org" },
    config = function()
      require("orgmode").setup({})
      require("orgmode").setup_ts_grammar()

      -- Treesitter configuration
      require({
        "nvim-treesitter/nvim-treesitter",
        -- If TS highlights are not enabled at all, or disabled via `disable` prop,
        -- highlighting will fallback to default Vim syntax highlighting
        opts = {
          highlight = {
            enable = true,
            -- Required for spellcheck, some LaTex highlights and
            -- code block highlights that do not have ts grammar
            additional_vim_regex_highlighting = { "org" },
          },
          ensure_installed = { "org" }, -- Or run :TSUpdate org
        },
      })
    end,
  },
}
