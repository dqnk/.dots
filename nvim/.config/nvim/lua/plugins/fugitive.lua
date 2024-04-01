return {
  -- add symbols-outline
  {
    "tpope/vim-fugitive",
    keys = {

      --{ "<leader>gs", "<cmd>Git<cr>", desc = "git-status" },
      --{ "<leader>gS", "<cmd>Git add %<cr>", desc = "stage-current-file" },
      --{ "<leader>gU", "<cmd>Git reset -q %<cr>", desc = "unstage-current-file" },
      --{ "<leader>gc", "<cmd>Git commit<cr>", desc = "edit-git-commit" },
      --{ "<leader>gp", "<cmd>Git push<cr>", desc = "git-push" },
      --{ "<leader>gd", "<cmd>Gdiffsplit<cr>", desc = "view-git-diff" },
      --{ "<leader>gA", "<cmd>Git add .<cr>", desc = "stage-all-files" },
      { "<leader>gb", "<cmd>Git blame<cr>", desc = "view-git-blame" },
      --{ "<leader>gV", "<cmd>Gclog -- %<cr>", desc = "git-log-of-current-file" },
      --{ "<leader>gv", "<cmd>Gclog --<cr>", desc = "git-log-of-current-repo" },
    },
    config = function() end,
  },
}
