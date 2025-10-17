-- ============================================================================
-- Plugin Specifications
-- This file defines all plugins to be loaded by lazy.nvim
-- ============================================================================

return {
  -- ==========================================================================
  -- Core Dependencies
  -- ==========================================================================
  "nvim-lua/plenary.nvim",
  "nvim-lua/popup.nvim",
  "MunifTanjim/nui.nvim",
  "rcarriga/nvim-notify",

  -- ==========================================================================
  -- Language Support
  -- ==========================================================================
  "LnL7/vim-nix",

  -- ==========================================================================
  -- Import organized plugin configurations
  -- These files contain the actual setup() calls and configurations
  -- ==========================================================================
  { import = "plugins.ui" },
  { import = "plugins.editor" },
  { import = "plugins.completion" },
  { import = "plugins.lsp" },
  { import = "plugins.git" },
  { import = "plugins.go" },
  { import = "plugins.copilot" },
}
