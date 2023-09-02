return {
  {
    "jackMort/ChatGPT.nvim",

    config = function()
      require("chatgpt").setup({ api_key_cmd = "gpg --decrypt " .. os.getenv("HOME") .. "/.openai-secret.txt.gpg" })
    end,
  },
}
