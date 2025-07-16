return {
  {
    "frankroeder/parrot.nvim",

    keys = {

      { "<leader>as", "<cmd>PrtChatToggle vsplit<cr>", mode = { "n", "v" }, desc = "Toggle LLM chat" },
      { "<leader>an", "<cmd>PrtChatNew vsplit<cr>", mode = { "n", "v" }, desc = "New LLM chat" },
      -- TODO: implement this feature?
      -- { "<leader>ac", "<cmd>PrtNextAgent<cr>", mode = { "n", "v" }, desc = "Cycle LLM" },
      { "<leader>ap", "<cmd>PrtProvider<cr>", mode = { "n", "v" }, desc = "Select LLM provider" },
      { "<leader>am", "<cmd>PrtModel<cr>", mode = { "n", "v" }, desc = "Select LLM" },
      { "<leader>af", "<cmd>PrtChatFinder<cr>", mode = { "n", "v" }, desc = "Find LLM chat" },
      { "<leader>ad", "<cmd>PrtChatDelete<cr>", mode = { "n", "v" }, desc = "Delete LLM chat" },
      { "<C-x>", "<cmd>PrtStop<cr>", mode = { "n", "v" }, desc = "Stop" },
    },

    config = {
      chat_shortcut_respond = { modes = { "n" }, shortcut = "<Enter>" },
      -- For customization, refer to Install > Configuration in the Documentation/Readme
      providers = {
        -- api_key =  { "bw", "get", "password", "OPENAI_API_KEY", "2> /dev/null" },
        -- `gpg -e -r <public key> -o .openai-secret.txt.gpg .openai-secret.txt 2> /dev/null`
        -- ^ obtain public key by `gpg --list-keys`, pick the one associated with your name
        -- stderr goes to /dev/null because it is printed for some reason
        openai = {
          name = "openai",
          endpoint = "https://api.openai.com/v1/chat/completions",
          model_endpoint = "https://api.openai.com/v1/models",
          api_key = { "gpg", "--decrypt", os.getenv("HOME") .. "/.openai-secret.txt.gpg", "2> /dev/null" },
          models = { "o4-mini", "gpt-4o", "o3-mini" },
        },

        anthropic = {
          name = "anthropic",
          endpoint = "https://api.anthropic.com/v1/messages",
          model_endpoint = "https://api.anthropic.com/v1/models",
          params = {
            chat = { max_tokens = 2048 },
            command = { max_tokens = 2048 },
          },
          api_key = { "gpg", "--decrypt", os.getenv("HOME") .. "/.anthropic-secret.txt.gpg", "2> /dev/null" },
          headers = function(self)
            return {
              ["Content-Type"] = "application/json",
              ["x-api-key"] = self.api_key,
              ["anthropic-version"] = "2023-06-01",
            }
          end,
          models = {
            "claude-sonnet-4-20250514",
            "claude-3-7-sonnet-20250219",
            "claude-3-5-sonnet-20241022",
          },
          preprocess_payload = function(payload)
            for _, message in ipairs(payload.messages) do
              message.content = message.content:gsub("^%s*(.-)%s*$", "%1")
            end
            if payload.messages[1] and payload.messages[1].role == "system" then
              -- remove the first message that serves as the system prompt as anthropic
              -- expects the system prompt to be part of the API call body and not the messages
              payload.system = payload.messages[1].content
              table.remove(payload.messages, 1)
            end
            return payload
          end,
        },
        gemini = {
          name = "gemini",
          endpoint = function(self)
            return "https://generativelanguage.googleapis.com/v1beta/models/"
              .. self._model
              .. ":streamGenerateContent?alt=sse"
          end,
          model_endpoint = function(self)
            return { "https://generativelanguage.googleapis.com/v1beta/models?key=" .. self.api_key }
          end,
          api_key = { "gpg", "--decrypt", os.getenv("HOME") .. "/.google-gemini-secret.txt.gpg", "2> /dev/null" },
          params = {
            chat = { temperature = 1.1, topP = 1, topK = 10, maxOutputTokens = 2048 },
            command = { temperature = 0.8, topP = 1, topK = 10, maxOutputTokens = 2048 },
          },
          headers = function(self)
            return {
              ["Content-Type"] = "application/json",
              ["x-goog-api-key"] = self.api_key,
            }
          end,
          models = {
            "gemini-2.5-flash-preview-05-20",
            "gemini-2.5-pro-preview-05-06",
          },
          preprocess_payload = function(payload)
            local contents = {}
            local system_instruction = nil
            for _, message in ipairs(payload.messages) do
              if message.role == "system" then
                system_instruction = { parts = { { text = message.content } } }
              else
                local role = message.role == "assistant" and "model" or "user"
                table.insert(
                  contents,
                  { role = role, parts = { { text = message.content:gsub("^%s*(.-)%s*$", "%1") } } }
                )
              end
            end
            local gemini_payload = {
              contents = contents,
              generationConfig = {
                temperature = payload.temperature,
                topP = payload.topP or payload.top_p,
                maxOutputTokens = payload.max_tokens or payload.maxOutputTokens,
              },
            }
            if system_instruction then
              gemini_payload.systemInstruction = system_instruction
            end
            return gemini_payload
          end,
          process_stdout = function(response)
            if not response or response == "" then
              return nil
            end
            local success, decoded = pcall(vim.json.decode, response)
            if
              success
              and decoded.candidates
              and decoded.candidates[1]
              and decoded.candidates[1].content
              and decoded.candidates[1].content.parts
              and decoded.candidates[1].content.parts[1]
            then
              return decoded.candidates[1].content.parts[1].text
            end
            return nil
          end,
        },

        -- github = {
        --   disable = true,
        --   endpoint = "https://api.githubcopilot.com/chat/completions",
        --   api_key =  {
        --     "bash",
        --     "-c",
        --     "cat ~/.config/github-copilot/hosts.json | sed -e 's/.*oauth_token...//;s/\".*//'",
        --   },
        -- },

        -- pplx = {
        --   disable = true,
        --   endpoint = "https://api.perplexity.ai/chat/completions",
        --   api_key =  os.getenv("PPLX_API_KEY"),
        -- },

        -- ollama = {
        --   disable = true,
        --   endpoint = "http://localhost:11434/v1/chat/completions",
        -- },

        -- gemini = {
        --   disable = true,
        --   endpoint = "https://generativelanguage.googleapis.com/v1beta/models/{{model}}:streamGenerateContent?key={{secret}}",
        --   api_key =  os.getenv("GOOGLEAI_API_KEY"),
        -- },
      },
      system_prompt = {
        chat = [[Act as a coding assistant to an experienced software developer, also answer non-coding questions.
        1. Keep a running context of the codebase, libraries, etc.
        2. Be concise, skip explanations unless specifically asked about them.
        3. When asked to explain, keep explanations brief and short, explain only the most relevant parts.
        4. Use code blocks for answers that include code.
        5. Ask specific questions if additional information is needed.
        6. If only code is provided, respond with `Code ingested: <filename/path>, <language>.` and assume follow-up questions relate to that code.
        7. If ready, respond with `READY`. ]],

        command = "",
      },

      -- Parrot doesn't use agents
      --agents = {
      --  {
      --    name = "ChatGPT4o",
      --    disable = true,
      --  },
      --  {
      --    name = "ChatGPT4o-mini",
      --    disable = true,
      --  },
      --  {
      --    provider = "openai",
      --    name = "GPT-4o",
      --    -- string with model name or table with model name and parameters
      --    chat = true,
      --    command = false,
      --    model = { model = "gpt-4o", temperature = 1.1, top_p = 1, max_tokens = 1000 },
      --    -- system prompt (use this to specify the persona/role of the AI)
      --    system_prompt = "Act as a coding assistant, also answer non-coding questions. I'm an advanced software engineer, adjust responses accordingly. Keep a running context of the codebase, libraries, etc. - Be concise, skip explanations unless asked. - Use code blocks for answers that include code. - Ask specific questions if additional information is needed. - If only code is provided, respond with `Code ingested: <filename/path>, <language>.` and assume follow-up questions relate to that code. If ready, respond with `READY`. ",
      --  },
      --  {
      --    provider = "openai",
      --    name = "GPT-o3-mini",
      --    -- string with model name or table with model name and parameters
      --    chat = true,
      --    command = false,
      --    model = { model = "o3-mini" },
      --    -- system prompt (use this to specify the persona/role of the AI)
      --    system_prompt = "Act as a coding assistant, also answer non-coding questions. I'm an advanced software engineer, adjust responses accordingly. Keep a running context of the codebase, libraries, etc. - Be concise, skip explanations unless asked. - Use code blocks for answers that include code. - Ask specific questions if additional information is needed. - If only code is provided, respond with `Code ingested: <filename/path>, <language>.` and assume follow-up questions relate to that code. If ready, respond with `READY`. ",
      --  },
      --  {
      --    name = "ChatClaude-3-Haiku",
      --    disable = true,
      --  },
      --  {
      --    name = "ChatClaude-3-5-Sonnet",
      --    disable = true,
      --  },
      --  {
      --    provider = "anthropic",
      --    name = "Sonnet",
      --    -- string with model name or table with model name and parameters
      --    model = { model = "claude-3-5-sonnet-20241022", temperature = 0.01, top_p = 1, max_tokens = 1000 },
      --    chat = true,
      --    command = false,
      --    -- system prompt (use this to specify the persona/role of the AI)
      --    system_prompt = "Act as a coding assistant, also answer non-coding questions. I'm an advanced software engineer, adjust responses accordingly. Keep a running context of the codebase, libraries, etc. - Be concise, skip explanations unless asked. - Use code blocks for answers that include code. - Ask specific questions if additional information is needed. - If only code is provided, respond with `Code ingested: <filename/path>, <language>.` and assume follow-up questions relate to that code. If ready, respond with `READY`. ",
      --  },
      --},
    },
  },
}
