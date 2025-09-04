return {
  "mfussenegger/nvim-dap",
  optional = true,
  dependencies = {
    "mfussenegger/nvim-dap-python",
    -- stylua: ignore
    keys = {
      { "<leader>dPt", function() require('dap-python').test_method() end, desc = "Debug Method", ft = "python" },
      { "<leader>dPc", function() require('dap-python').test_class() end, desc = "Debug Class", ft = "python" },
    },
    config = function()
      if vim.fn.has("win32") == 1 then
        require("dap-python").setup(LazyVim.get_pkg_path("debugpy", "/venv/Scripts/pythonw.exe"))
      else
        require("dap-python").setup(LazyVim.get_pkg_path("debugpy", "/venv/bin/python"))
        table.insert(require("dap").configurations.python, 2, {
          type = "python",
          request = "attach",
          name = "attach remote",
          pathMappings = function()
            local remoteRoot = vim.fn.input("Remote root [/app]")
            remoteRoot = remoteRoot ~= "" and remoteRoot or "/app"
            return {
              {
                localRoot = vim.fn.getcwd(), -- Wherever your Python code lives locally.
                remoteRoot = remoteRoot, -- Wherever your Python code lives in the container.
              },
            }
          end,
          connect = function()
            local host = vim.fn.input("Host [127.0.0.1]: ")
            host = host ~= "" and host or "127.0.0.1"
            local port = tonumber(vim.fn.input("Port [5678]: ")) or 5678
            return { host = host, port = port }
          end,
        })
      end
    end,
  },
}
