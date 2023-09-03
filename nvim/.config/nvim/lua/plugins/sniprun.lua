return {
  {
    "michaelb/sniprun",
    build = "sh ./install.sh",
    keys = {
      {
        "<leader>rr",
        ":let b:caret=winsaveview() <CR> | :%SnipRun <CR>| :call winrestview(b:caret) <CR>",
        desc = "Run file",
      },
      { "<leader>rl", "<cmd>'<,'>SnipRun<cr>", mode = { "v" }, desc = "Run selected" },
      { "<leader>rl", "<cmd>SnipRun<cr>", mode = { "n" }, desc = "Run line" },
    },
  },
}
