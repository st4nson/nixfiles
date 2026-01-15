-- ============================================================================
-- Neovim Configuration
-- Entry Point: init.lua
-- ============================================================================
--
-- This is a modular Neovim configuration organized into logical sections:
--
-- Structure:
--   lua/
--   ├── config/          - Core Neovim configuration
--   │   ├── lazy.lua     - Lazy.nvim bootstrap
--   │   ├── options.lua  - Vim options and settings
--   │   ├── keymaps.lua  - General keymaps
--   │   └── autocmds.lua - Autocommands
--   └── plugins/         - Plugin configurations
--       ├── init.lua     - Plugin specifications
--       ├── ui.lua       - UI plugins (colorscheme, statusline, etc.)
--       ├── editor.lua   - Editor plugins (tree, telescope, etc.)
--       ├── completion.lua - Completion engine (nvim-cmp)
--       ├── lsp.lua      - LSP configuration
--       ├── git.lua      - Git integration
--       ├── go.lua       - Go development
--       └── copilot.lua  - GitHub Copilot
--
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
