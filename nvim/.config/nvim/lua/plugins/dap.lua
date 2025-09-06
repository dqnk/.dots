return {
  "mfussenegger/nvim-dap",
  optional = true,
  -- disconnect, useful specifically for python debugpy
  keys = {
    {
      "<Leader>dd",
      function()
        require("dap").disconnect({ terminateDebuggee = false })
      end,
      desc = "Disconnect",
    },
    {
      "<leader>dt",
      function()
        if vim.fn.confirm("Terminate debug session?", "&Yes\n&No", 1) == 1 then
          require("dap").terminate()
        end
      end,
      desc = "Terminate",
    },
  },
}
