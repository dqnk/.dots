return {
  {
    "jackMort/ChatGPT.nvim",

    keys = {

      { "<leader>as", "<cmd>ChatGPT<cr>", desc = "ChatGPT" },
      { "<leader>af", "<cmd>ChatGPTActAs<cr>", desc = "ChatGPT act as" },
      { "<leader>ac", "<cmd>ChatGPTCompleteCode<cr>", desc = "ChatGPT complete code" },
      { "<leader>an", "<cmd>ChatGPTEditWithInstructions<cr>", desc = "ChatGPT edit with instructions" },
    },
    config = function()
      require("chatgpt").setup({ api_key_cmd = "gpg --decrypt " .. os.getenv("HOME") .. "/.openai-secret.txt.gpg" })
    end,
  },
}
