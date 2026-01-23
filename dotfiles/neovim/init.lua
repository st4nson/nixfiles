-- ============================================================================
-- Neovim Configuration
-- Entry Point: init.lua
-- ============================================================================

-- Bootstrap lazy.nvim plugin manager
require("config.lazy")

-- Load core configuration
require("config.options")

-- Setup lazy.nvim with plugin specifications
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  install = {
    colorscheme = { "catppuccin-macchiato" }
  },
  checker = {
    enabled = false
  },
  ui = {
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  },
})

-- Load keymaps (after plugins are loaded)
require("config.keymaps")

-- Load autocommands
require("config.autocmds")
