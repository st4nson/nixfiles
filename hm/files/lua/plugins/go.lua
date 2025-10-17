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
      require('go').setup()
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
  -- DAP: Debug Adapter Protocol
  -- ============================================================================
  {
    "mfussenegger/nvim-dap",
  },

  {
    "leoluz/nvim-dap-go",
    dependencies = { "mfussenegger/nvim-dap" },
  },

  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap" },
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
  },

  {
    "nvim-neotest/nvim-nio",
  },
}
