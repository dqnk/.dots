return {
  {
    "michaelb/sniprun",
    build = "sh ./install.sh",
    keys = {
      { "<leader>rr", "<cmd>normal! gg<cr><cmd>%SnipRun<cr><C-o>", desc = "Run file" },
      { "<leader>rl", "<cmd>'<,'>SnipRun<cr>", mode = { "n", "v" }, desc = "Run selected" },
    },
  },
}
