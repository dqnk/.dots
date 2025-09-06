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
  },
}
