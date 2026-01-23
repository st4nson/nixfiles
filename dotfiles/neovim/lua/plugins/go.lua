-- ============================================================================
-- Go Development Plugins
-- ============================================================================

return {
  -- ============================================================================
  -- Go.nvim: Go development plugin
  -- ============================================================================
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      -- lsp_codelens disabled: go.nvim master assumes Neovim 0.12+
      -- (vim.lsp.codelens.enable). Re-enable once we upgrade.
      require('go').setup({ lsp_codelens = false })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
  },

  -- ============================================================================
  -- Guihua: GUI library for go.nvim
  -- ============================================================================
  {
    "ray-x/guihua.lua",
    build = "cd lua/fzy && make",
  },

  -- ============================================================================
  -- DAP: Debug Adapter Protocol (Go + general)
  -- Requires `delve` on PATH (install via `go install github.com/go-delve/delve/cmd/dlv@latest`)
  -- ============================================================================
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "leoluz/nvim-dap-go",
      "nvim-neotest/nvim-nio",
    },
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "DAP: toggle breakpoint" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "DAP: conditional breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "DAP: continue / start" },
      { "<leader>do", function() require("dap").step_over() end, desc = "DAP: step over" },
      { "<leader>di", function() require("dap").step_into() end, desc = "DAP: step into" },
      { "<leader>dO", function() require("dap").step_out() end, desc = "DAP: step out" },
      { "<leader>dr", function() require("dap").repl.open() end, desc = "DAP: open REPL" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "DAP: run last" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "DAP: toggle UI" },
      { "<leader>de", function() require("dapui").eval() end, mode = { "n", "v" }, desc = "DAP: eval expression" },
      { "<leader>dt", function() require("dap-go").debug_test() end, desc = "DAP: debug nearest Go test" },
      { "<leader>dT", function() require("dap-go").debug_last_test() end, desc = "DAP: debug last Go test" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()
      require("nvim-dap-virtual-text").setup({})
      require("dap-go").setup()

      -- Auto open/close dap-ui around debug sessions
      dap.listeners.before.attach.dapui_config = function() dapui.open() end
      dap.listeners.before.launch.dapui_config = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
      dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

      -- Sign column glyphs
      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "→", texthl = "DiagnosticInfo", linehl = "Visual", numhl = "" })
    end,
  },
}
