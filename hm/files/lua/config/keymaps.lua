-- ============================================================================
-- Keymaps Configuration
-- ============================================================================

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ============================================================================
-- Command Mode
-- ============================================================================

-- Sudo write - save file with sudo
vim.api.nvim_set_keymap("c", "w!!", "w !sudo tee % >/dev/null", opts)

-- ============================================================================
-- Buffer Navigation
-- ============================================================================

keymap("n", "<leader>[", ":bprevious<CR>", opts)  -- Previous buffer
keymap("n", "<leader>]", ":bnext<CR>", opts)      -- Next buffer
keymap("n", "<leader>;", ":BD<CR>", opts)         -- Delete buffer (vim-bufkill)

-- ============================================================================
-- File Tree (NvimTree)
-- ============================================================================

keymap("n", "<F7>", ":NvimTreeToggle<CR>", opts)        -- Toggle file tree
keymap("n", "<leader><F7>", ":NvimTreeFindFile<CR>", opts)  -- Find current file in tree

-- ============================================================================
-- Terminal (Floaterm)
-- ============================================================================

keymap("n", "<leader>e", ":FloatermToggle<CR>", opts)                           -- Toggle terminal
keymap("t", "<leader>e", "<C-\\><C-n>:FloatermToggle<CR>", opts)                -- Toggle from terminal mode
keymap("n", "<leader>ftn", ":FloatermNext<CR>", opts)                           -- Next terminal
keymap("t", "<leader>ftn", "<C-\\><C-n>:FloatermNext<CR>", opts)                -- Next terminal from terminal mode

-- ============================================================================
-- Telescope (Fuzzy Finder)
-- ============================================================================

local telescope_builtin = require('telescope.builtin')

keymap('n', "<C-p>", telescope_builtin.find_files, opts)     -- Find files
keymap('n', "<leader>'", telescope_builtin.buffers, opts)    -- Find buffers
keymap('n', "<leader>q", telescope_builtin.tags, opts)       -- Find tags
keymap('n', "<leader>=", telescope_builtin.oldfiles, opts)   -- Recent files
keymap('n', "<leader>se", telescope_builtin.live_grep, opts) -- Live grep
keymap('n', "<leader>gs", telescope_builtin.git_status, opts) -- Git status

-- ============================================================================
-- LSP Keymaps
-- ============================================================================
-- Note: LSP keymaps are configured in lua/plugins/lsp.lua via LspAttach autocmd
-- This ensures they only load when LSP attaches to a buffer

-- ============================================================================
-- Diagnostic Navigation
-- ============================================================================

keymap('n', '<space>e', vim.diagnostic.open_float, opts)    -- Open diagnostic float
keymap('n', '[d', vim.diagnostic.goto_prev, opts)           -- Previous diagnostic
keymap('n', ']d', vim.diagnostic.goto_next, opts)           -- Next diagnostic
keymap('n', '<space>q', vim.diagnostic.setloclist, opts)    -- Set location list

-- ============================================================================
-- CopilotChat
-- ============================================================================

local chat = require("CopilotChat")
keymap('n', "<leader>co", chat.toggle, opts)                -- Toggle Copilot chat
