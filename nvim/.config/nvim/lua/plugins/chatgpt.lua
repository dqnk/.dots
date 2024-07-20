return {
  {
    "dqnk/ChatGPT.nvim",

    keys = {

      { "<leader>as", "<cmd>ChatGPT<cr>", mode = { "n", "v" }, desc = "ChatGPT" },
      { "<leader>af", "<cmd>ChatGPTActAs<cr>", desc = "ChatGPT act as" },
      { "<leader>ac", "<cmd>ChatGPTCompleteCode<cr>", desc = "ChatGPT complete code" },
      {
        "<leader>an",
        "<cmd>ChatGPTEditWithInstructions<cr>",
        mode = { "n", "v" },
        desc = "ChatGPT edit with instructions",
      },
    },
    opts = {
      api_key_cmd = "gpg --decrypt " .. os.getenv("HOME") .. "/.openai-secret.txt.gpg",
      chat = {
        keymaps = { new_session = "<C-a>" },
      },

      popup_layout = {
        default = "center",
        center = {
          width = "100%",
          height = "100%",
        },
        right = {
          width = "30%",
          width_settings_open = "80%",
        },
      },
      popup_input = {
        prompt = "  ",
        border = {
          highlight = "FloatBorder",
          style = "rounded",
          text = {
            top_align = "center",
            top = " Prompt ",
          },
        },
        win_options = {
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
        },
        submit = "<C-Enter>",
        submit_n = "<Enter>",
        max_visible_lines = 40,
      },
    },
  },
}
