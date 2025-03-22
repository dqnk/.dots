return {
  {
    "dqnk/gp.nvim",
    -- replaced by frankroeder/parrot.nvim
    enabled = false,

    keys = {

      { "<leader>as", "<cmd>GpChatToggle vsplit<cr>", mode = { "n", "v" }, desc = "Toggle LLM chat" },
      { "<leader>an", "<cmd>GpChatNew vsplit<cr>", mode = { "n", "v" }, desc = "New LLM chat" },
      { "<leader>ac", "<cmd>GpNextAgent<cr>", mode = { "n", "v" }, desc = "Cycle LLM" },
      { "<leader>ad", "<cmd>GpChatDelete<cr>", mode = { "n", "v" }, desc = "Delete LLM chat" },
      { "<C-x>", "<cmd>GpStop<cr>", mode = { "n", "v" }, desc = "Stop" },
    },

    config = {
      chat_shortcut_respond = { modes = { "n" }, shortcut = "<Enter>" },
      -- For customization, refer to Install > Configuration in the Documentation/Readme
      providers = {
        -- secret = { "bw", "get", "password", "OPENAI_API_KEY" },
        -- `gpg -e -r <public key> -o .openai-secret.txt.gpg .openai-secret.txt`
        -- ^ obtain public key by `gpg --list-keys`, pick the one associated with your name
        openai = {
          --endpoint = "https://api.openai.com/v1/chat/completions",
          secret = { "gpg", "--decrypt", os.getenv("HOME") .. "/.openai-secret.txt.gpg" },
        },

        anthropic = {
          -- endpoint = "https://api.anthropic.com/v1/messages",
          secret = { "gpg", "--decrypt", os.getenv("HOME") .. "/.anthropic-secret.txt.gpg" },
        },

        copilot = {
          disable = true,
          endpoint = "https://api.githubcopilot.com/chat/completions",
          secret = {
            "bash",
            "-c",
            "cat ~/.config/github-copilot/hosts.json | sed -e 's/.*oauth_token...//;s/\".*//'",
          },
        },

        pplx = {
          disable = true,
          endpoint = "https://api.perplexity.ai/chat/completions",
          secret = os.getenv("PPLX_API_KEY"),
        },

        ollama = {
          disable = true,
          endpoint = "http://localhost:11434/v1/chat/completions",
        },

        googleai = {
          disable = true,
          endpoint = "https://generativelanguage.googleapis.com/v1beta/models/{{model}}:streamGenerateContent?key={{secret}}",
          secret = os.getenv("GOOGLEAI_API_KEY"),
        },
      },
      agents = {
        {
          name = "ChatGPT4o",
          disable = true,
        },
        {
          name = "ChatGPT4o-mini",
          disable = true,
        },
        {
          provider = "openai",
          name = "GPT-4o",
          -- string with model name or table with model name and parameters
          chat = true,
          command = false,
          model = { model = "gpt-4o", temperature = 1.1, top_p = 1, max_tokens = 1000 },
          -- system prompt (use this to specify the persona/role of the AI)
          system_prompt = "Act as a coding assistant, also answer non-coding questions. I'm an advanced software engineer, adjust responses accordingly. Keep a running context of the codebase, libraries, etc. - Be concise, skip explanations unless asked. - Use code blocks for answers that include code. - Ask specific questions if additional information is needed. - If only code is provided, respond with `Code ingested: <filename/path>, <language>.` and assume follow-up questions relate to that code. If ready, respond with `READY`. ",
        },
        {
          provider = "openai",
          name = "GPT-o3-mini",
          -- string with model name or table with model name and parameters
          chat = true,
          command = false,
          model = { model = "o3-mini" },
          -- system prompt (use this to specify the persona/role of the AI)
          system_prompt = "Act as a coding assistant, also answer non-coding questions. I'm an advanced software engineer, adjust responses accordingly. Keep a running context of the codebase, libraries, etc. - Be concise, skip explanations unless asked. - Use code blocks for answers that include code. - Ask specific questions if additional information is needed. - If only code is provided, respond with `Code ingested: <filename/path>, <language>.` and assume follow-up questions relate to that code. If ready, respond with `READY`. ",
        },
        {
          name = "ChatClaude-3-Haiku",
          disable = true,
        },
        {
          name = "ChatClaude-3-5-Sonnet",
          disable = true,
        },
        {
          provider = "anthropic",
          name = "Sonnet",
          -- string with model name or table with model name and parameters
          model = { model = "claude-3-5-sonnet-20241022", temperature = 0.01, top_p = 1, max_tokens = 1000 },
          chat = true,
          command = false,
          -- system prompt (use this to specify the persona/role of the AI)
          system_prompt = "Act as a coding assistant, also answer non-coding questions. I'm an advanced software engineer, adjust responses accordingly. Keep a running context of the codebase, libraries, etc. - Be concise, skip explanations unless asked. - Use code blocks for answers that include code. - Ask specific questions if additional information is needed. - If only code is provided, respond with `Code ingested: <filename/path>, <language>.` and assume follow-up questions relate to that code. If ready, respond with `READY`. ",
        },
      },
    },
  },
}
