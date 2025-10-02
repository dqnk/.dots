return {
  "CopilotC-Nvim/CopilotChat.nvim",
  branch = "main",
  cmd = "CopilotChat",
  enabled = false,
  opts = function()
    -- source: https://github.com/frankroeder/parrot.nvim/blob/main/lua/parrot/provider/multi_provider.lua#L148-L148
    local get_api_key = function(command)
      local cmd = table.concat(command, " ")
      -- Use a timeout to prevent hanging on command execution
      local handle = io.popen(cmd) -- Capture stderr as well
      if handle then
        local resolved_key = handle:read("*a")
        handle:close()

        -- Clean up the resolved key
        resolved_key = resolved_key:gsub("%s+$", ""):gsub("^%s+", "")
        if resolved_key == "" then
          error("Error verifying API key for provider " .. self.name .. ": command returned empty result")
          return false
        end
        return resolved_key
      end
    end

    return {
      providers = {
        copilot = { disabled = true },

        anthropic = {

          prepare_input = function(input, opts)
            local payload = require("CopilotChat.config.providers").copilot.prepare_input(input, opts)
            for _, message in ipairs(payload.messages) do
              message.content = message.content:gsub("^%s*(.-)%s*$", "%1")
            end
            if payload.messages[1] and payload.messages[1].role == "system" then
              -- remove the first message that serves as the system prompt as anthropic
              -- expects the system prompt to be part of the API call body and not the messages
              payload.system = payload.messages[1].content
              table.remove(payload.messages, 1)
            end
            -- Anthropic API requires max_tokens field
            payload.max_tokens = payload.max_tokens or 4096
            -- Remove fields that Anthropic doesn't support
            payload.n = nil
            payload.top_t = nil
            return payload
          end,
          prepare_output = require("CopilotChat.config.providers").copilot.prepare_output,

          get_url = function()
            return "https://api.anthropic.com/v1/messages"
          end,

          get_headers = function()
            local command = { "gpg", "--decrypt", os.getenv("HOME") .. "/.anthropic-secret.txt.gpg", "2> /dev/null" }
            local api_key = get_api_key(command)
            return {
              ["Content-Type"] = "application/json",
              ["x-api-key"] = api_key,
              ["anthropic-version"] = "2023-06-01",
            }
          end,

          get_models = function(headers)
            local response, err = require("CopilotChat.utils.curl").get("https://api.anthropic.com/v1/models", {
              headers = headers,
              json_response = true,
            })
            if err then
              error(err)
            end
            return vim
              .iter(response.body.data)
              :filter(function(model)
                local exclude_patterns = {
                  -- TODO: anthropic exclude patterns?
                  "audio",
                  "babbage",
                  "dall%-e",
                  "davinci",
                  "embedding",
                  "image",
                  "moderation",
                  "realtime",
                  "transcribe",
                  "tts",
                  "whisper",
                }
                for _, pattern in ipairs(exclude_patterns) do
                  if model.id:match(pattern) then
                    return false
                  end
                end
                return true
              end)
              :map(function(model)
                return {
                  id = model.id,
                  name = model.id,
                }
              end)
              :totable()
          end,
        },

        openai = {
          prepare_input = require("CopilotChat.config.providers").copilot.prepare_input,
          prepare_output = require("CopilotChat.config.providers").copilot.prepare_output,

          get_url = function()
            return "https://api.openai.com/v1/chat/completions"
          end,

          get_headers = function()
            local command = { "gpg", "--decrypt", os.getenv("HOME") .. "/.openai-secret.txt.gpg", "2> /dev/null" }
            local api_key = get_api_key(command)
            return {
              Authorization = "Bearer " .. api_key,
              ["Content-Type"] = "application/json",
            }
          end,

          get_models = function(headers)
            local response, err = require("CopilotChat.utils.curl").get("https://api.openai.com/v1/models", {
              headers = headers,
              json_response = true,
            })
            if err then
              error(err)
            end
            return vim
              .iter(response.body.data)
              :filter(function(model)
                local exclude_patterns = {
                  "audio",
                  "babbage",
                  "dall%-e",
                  "davinci",
                  "embedding",
                  "image",
                  "moderation",
                  "realtime",
                  "transcribe",
                  "tts",
                  "whisper",
                }
                for _, pattern in ipairs(exclude_patterns) do
                  if model.id:match(pattern) then
                    return false
                  end
                end
                return true
              end)
              :map(function(model)
                return {
                  id = model.id,
                  name = model.id,
                }
              end)
              :totable()
          end,
        },

        gemini = {
          prepare_input = require("CopilotChat.config.providers").copilot.prepare_input,
          prepare_output = require("CopilotChat.config.providers").copilot.prepare_output,

          get_headers = function()
            local command =
              { "gpg", "--decrypt", os.getenv("HOME") .. "/.google-gemini-secret.txt.gpg", "2> /dev/null" }
            local api_key = get_api_key(command)
            return {
              Authorization = "Bearer " .. api_key,
              ["Content-Type"] = "application/json",
            }
          end,

          get_models = function(headers)
            local response, err =
              require("CopilotChat.utils.curl").get("https://generativelanguage.googleapis.com/v1beta/openai/models", {
                headers = headers,
                json_response = true,
              })

            if err then
              error(err)
            end

            return vim.tbl_map(function(model)
              local id = model.id:gsub("^models/", "")
              return {
                id = id,
                name = id,
                streaming = true,
                tools = true,
              }
            end, response.body.data)
          end,

          get_url = function()
            return "https://generativelanguage.googleapis.com/v1beta/openai/chat/completions"
          end,
        },

        openrouter = {
          prepare_input = require("CopilotChat.config.providers").copilot.prepare_input,
          prepare_output = require("CopilotChat.config.providers").copilot.prepare_output,

          get_headers = function()
            local command = { "gpg", "--decrypt", os.getenv("HOME") .. "/.openrouter-secret.txt.gpg", "2> /dev/null" }
            local api_key = get_api_key(command)
            return {
              Authorization = "Bearer " .. api_key,
              ["Content-Type"] = "application/json",
            }
          end,

          get_models = function(headers)
            local response, err = require("CopilotChat.utils.curl").get("https://openrouter.ai/api/v1/models", {
              headers = headers,
              json_response = true,
            })

            if err then
              error(err)
            end

            return vim
              .iter(response.body.data)
              :map(function(model)
                return {
                  id = model.id,
                  name = model.name,
                }
              end)
              :totable()
          end,

          get_url = function()
            return "https://openrouter.ai/api/v1/chat/completions"
          end,
        },
      },
    }
  end,

  keys = {
    { "<c-s>", "<CR>", ft = "copilot-chat", desc = "Submit Prompt", remap = true },
    { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
    {
      "<leader>aa",
      function()
        return require("CopilotChat").toggle()
      end,
      desc = "Toggle (CopilotChat)",
      mode = { "n", "v" },
    },
    {
      "<leader>ax",
      function()
        return require("CopilotChat").reset()
      end,
      desc = "Clear (CopilotChat)",
      mode = { "n", "v" },
    },
    {
      "<leader>aq",
      function()
        vim.ui.input({
          prompt = "Quick Chat: ",
        }, function(input)
          if input ~= "" then
            require("CopilotChat").ask(input)
          end
        end)
      end,
      desc = "Quick Chat (CopilotChat)",
      mode = { "n", "v" },
    },
    {
      "<leader>ap",
      function()
        require("CopilotChat").select_prompt()
      end,
      desc = "Prompt Actions (CopilotChat)",
      mode = { "n", "v" },
    },
  },
}
