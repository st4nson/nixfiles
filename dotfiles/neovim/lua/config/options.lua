-- ============================================================================
-- Neovim Options Configuration
-- ============================================================================

local opt = vim.opt

-- ============================================================================
-- Editor Behavior
-- ============================================================================

opt.mouse = "a"                     -- Enable mouse support
opt.termguicolors = true            -- Enable 24-bit RGB colors
opt.updatetime = 250                -- Update interval (ms) for CursorHold events
opt.synmaxcol = 250                 -- Syntax highlighting only for first 250 chars (performance)

-- ============================================================================
-- Indentation
-- ============================================================================

opt.tabstop = 4                     -- Number of spaces that a <Tab> counts for
opt.shiftwidth = 4                  -- Number of spaces to use for each step of (auto)indent
opt.expandtab = true                -- Use spaces instead of tabs
opt.autoindent = true               -- Copy indent from current line when starting new line
opt.backspace = { "indent", "eol", "start" }  -- Allow backspacing over everything

-- ============================================================================
-- Display
-- ============================================================================

opt.number = true                   -- Show line numbers
opt.colorcolumn = "121"             -- Highlight column 121
opt.scrolloff = 4                   -- Minimum lines to keep above/below cursor
opt.encoding = "utf-8"              -- Set encoding

-- Custom list characters
opt.listchars = {
  eol = '↵',
  trail = '•',
  tab = '| '
}

-- ============================================================================
-- Search
-- ============================================================================

opt.hlsearch = true                 -- Highlight search results
opt.incsearch = true                -- Show search matches as you type
opt.ignorecase = true               -- Ignore case in search patterns
opt.smartcase = true                -- Override ignorecase if search contains uppercase

-- ============================================================================
-- System Integration
-- ============================================================================

opt.clipboard = "unnamedplus"       -- Use system clipboard

-- ============================================================================
-- Undo and Backup
-- ============================================================================

-- Set persistent undo
local undo_dir = vim.fn.stdpath("state") .. "/undo"
vim.fn.mkdir(undo_dir, "p")
opt.undofile = true
opt.undodir = undo_dir

-- Disable swap and backup files
opt.swapfile = false
opt.backup = false
opt.writebackup = false
