# Neovim Configuration Structure

This is a modular Neovim configuration organized for readability and maintainability.

## Directory Structure

```
lua/
├── config/              Core Neovim configuration
│   ├── lazy.lua        Lazy.nvim bootstrap
│   ├── options.lua     Vim options and settings
│   ├── keymaps.lua     General keymaps
│   └── autocmds.lua    Autocommands
└── plugins/            Plugin configurations
    ├── init.lua        Plugin specifications
    ├── ui.lua          UI plugins (colorscheme, statusline, etc.)
    ├── editor.lua      Editor plugins (tree, telescope, etc.)
    ├── completion.lua  Completion engine (nvim-cmp)
    ├── lsp.lua         LSP configuration
    ├── git.lua         Git integration
    ├── go.lua          Go development
    └── copilot.lua     GitHub Copilot
```

## File Descriptions

### Core Configuration (`config/`)

#### `lazy.lua`
Bootstraps the lazy.nvim plugin manager. This must be loaded first before any plugins.

#### `options.lua`
Contains all Vim options organized by category:
- Editor behavior
- Indentation settings
- Display options
- Search configuration
- System integration
- Undo and backup settings

#### `keymaps.lua`
General keymaps organized by functionality:
- Command mode shortcuts
- Buffer navigation
- File tree (NvimTree)
- Terminal (Floaterm)
- Telescope (fuzzy finder)
- Diagnostic navigation
- CopilotChat

**Note:** LSP-specific keymaps are defined in `plugins/lsp.lua` via the LspAttach autocmd to ensure they only load when LSP attaches to a buffer.

#### `autocmds.lua`
Autocommands for file-specific behavior:
- Go formatting on save
- Terraform formatting on save

### Plugin Configurations (`plugins/`)

#### `init.lua`
Main plugin specification file. Lists all plugins and imports other plugin configuration files.

#### `ui.lua`
UI-related plugins:
- Catppuccin colorscheme
- Lualine (statusline)
- Bufferline
- Web devicons
- Colorizer
- Noice (better UI for messages)

#### `editor.lua`
Editor enhancement plugins:
- NvimTree (file explorer)
- Telescope (fuzzy finder)
- Floaterm (floating terminal)
- Vim-test
- Vim-slime
- Motion plugins (easymotion, surround, etc.)
- VimWiki

#### `completion.lua`
Completion engine and sources:
- nvim-cmp setup
- LSP kind (icons)
- Completion sources (buffer, path, emoji, etc.)
- UltiSnips snippets

#### `lsp.lua`
LSP configuration:
- LSP server configurations (gopls, ts_ls, terraformls, etc.)
- LSP keymaps (via LspAttach autocmd)
- LSP signature
- Goto preview
- Treesitter

#### `git.lua`
Git integration:
- vim-fugitive
- Gitsigns (git decorations and keymaps)

#### `go.lua`
Go development tools:
- go.nvim
- DAP (Debug Adapter Protocol)
- DAP UI

#### `copilot.lua`
GitHub Copilot integration:
- Copilot.lua
- CopilotChat with custom prompts

## Adding New Plugins

1. **Add plugin spec to appropriate file** in `plugins/`
2. **Add configuration** in the same file using the `config` function
3. **Add keymaps** in `config/keymaps.lua` or within the plugin config if plugin-specific

Example:
```lua
-- In plugins/editor.lua
{
  "plugin-name/plugin-repo",
  config = function()
    require('plugin-name').setup({
      -- configuration here
    })
  end,
}
```

## Modifying Options

Edit `config/options.lua` to change Vim behavior. Options are grouped by category for easy navigation.

## Modifying Keymaps

Edit `config/keymaps.lua` for general keymaps, or the specific plugin file for plugin-related keymaps.

## Benefits of This Structure

- **Modularity**: Each concern is separated into its own file
- **Discoverability**: Easy to find specific configurations
- **Maintainability**: Changes to one plugin don't affect others
- **Performance**: Proper lazy loading reduces startup time
- **Documentation**: Self-documenting structure with clear naming

## Migration Notes

The original `init.lua` has been backed up to `init.lua.backup`. All functionality has been preserved and reorganized into this modular structure.
