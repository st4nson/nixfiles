require("config.lazy")

-- vim:set noet sts=0 sw=2 ts=2:
vim.opt.mouse = "a"

vim.opt.termguicolors = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.backspace = indent,eol,start

-- Custom list chars
vim.opt.encoding = "utf-8"
vim.opt.listchars = {
	eol = '↵',
	trail = '•',
	tab = '| '
}

-- Searching
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Show line numbers and ruler
vim.opt.number = true
vim.opt.colorcolumn = "121"

vim.opt.autoindent = true -- autosave files on :make
vim.opt.updatetime = 250  -- update each 250ms
vim.opt.synmaxcol = 250   -- syntax hi. only for first 250 chars. Speed improvement
                          -- for files with long lines

--  sudo write
vim.api.nvim_set_keymap("c", "w!!", "w !sudo tee % >/dev/null", { noremap = true, silent = true })

-- Set persistent undo
HOME = os.getenv("HOME")
vim.opt.undofile = true
vim.opt.undodir = HOME .. "/.vim/undodir"

-- Disable swap and backup files
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- import your plugins
		{ import = "plugins" },
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "catppuccin-macchiato" } },
	-- automatically check for plugin updates
	checker = { enabled = false },
	ui = {
		border = { "╭", "─" ,"╮", "│", "╯", "─", "╰", "│" },
  },
})

-- buffers navigation
vim.api.nvim_set_keymap("n", "<leader>[", ":bprevious<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>]", ":bnext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>;", ":BD<CR>", { noremap = true, silent = true })

-- vim-floaterm
vim.g.floaterm_autoclose = 1 -- close window on success
vim.g.floaterm_autohide = 2  -- always autohide

vim.g.floaterm_width = 0.9
vim.g.floaterm_height = 0.8
vim.g.floaterm_borderchars = "─│─│╭╮╯╰"

-- Set floating window border line color
vim.api.nvim_set_hl(0, 'FloatermBorder',{ bg = '#2e3440',  fg = '#81a1c1' })

vim.api.nvim_set_keymap("n", "<leader>e", ":FloatermToggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<leader>e", "<C-\\><C-n>:FloatermToggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ftn", ":FloatermNext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<leader>ftn", "<C-\\><C-n>:FloatermNext<CR>", { noremap = true, silent = true })

-- terraform-vim
vim.g.terraform_fmt_on_save = 1

-- vim-slime
vim.g.slime_target = "tmux"
vim.g.slime_paste_file = HOME .. "/.slime_paste"
vim.g.slime_dont_ask_default = 1
vim.g.slime_default_config = {
	socket_name = "default",
	target_pane = ":.1",
}

-- colorizer
require'colorizer'.setup()

-- Nvim-Tree
vim.api.nvim_set_keymap("n", "<F7>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader><F7>", ":NvimTreeFindFile<CR>", { noremap = true, silent = true })

require'nvim-tree'.setup {
  renderer = {
    indent_markers = {
      enable = true;
    },
  },
}

-- vim-test
vim.cmd([[
function! CustomFloatermStrategy(cmd)
  execute 'FloatermNew --name=vim-test --autoclose=0 --height=0.4 --width=0.6 --wintype=float --position=topright '.a:cmd
endfunction

let g:test#custom_strategies = {'custom_floaterm': function('CustomFloatermStrategy')}
let g:test#strategy = 'custom_floaterm'
]])

-- lualine
require'lualine'.setup{
  options = { theme  = 'catppuccin-macchiato' },
}

-- bufferline
require("bufferline").setup{
  options = {
    -- separator_style = "padded_slant",
    diagnostics = "nvim_lsp",
  }
}

local select_one_or_multi = function(prompt_bufnr)
  local picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
  local multi = picker:get_multi_selection()
  if not vim.tbl_isempty(multi) then
    require('telescope.actions').close(prompt_bufnr)
    for _, j in pairs(multi) do
      if j.path ~= nil then
        vim.cmd(string.format('%s %s', 'edit', j.path))
      end
    end
  else
    require('telescope.actions').select_default(prompt_bufnr)
  end
end

-- Telescope
require('telescope').setup{
  -- ...
--	extensions = {
--		["ui-select"] = {
--			require("telescope.themes").get_dropdown {
--			}
--		}
--	}
  defaults = {
    prompt_prefix = "🔍",
    mappings = {
      i = {
        ['<CR>'] = select_one_or_multi,
      }
    }
  }
}

local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', "<C-p>", telescope_builtin.find_files, { noremap = true, silent = true })
vim.keymap.set('n', "<leader>'", telescope_builtin.buffers, { noremap = true, silent = true })
vim.keymap.set('n', "<leader>q", telescope_builtin.tags, { noremap = true, silent = true })
vim.keymap.set('n', "<leader>=", telescope_builtin.oldfiles, { noremap = true, silent = true })
vim.keymap.set('n', "<leader>se", telescope_builtin.live_grep, { noremap = true, silent = true })
vim.keymap.set('n', "<leader>gs", telescope_builtin.git_status, { noremap = true, silent = true })

require("telescope").load_extension("ui-select")

-- local trouble = require('trouble')
-- vim.keymap.set("n", "<leader>t", trouble.toggle, { noremap = true, silent = true })

-- nvim-cmp
local lspkind = require "lspkind"
lspkind.init()

local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },

  mapping = cmp.mapping.preset.insert(),

  sources = {
		{ name = "copilot", group_index = 2 },
    { name = 'nvim_lsp' },
    { name = 'ultisnips' }, -- For ultisnips users.
    { name = 'buffer', keyword_length = 3 },
    { name = 'path' },
    --{ name = 'treesitter' },
    { name = 'emoji' }
  },

  completion = { completeopt = 'menu,menuone,noinsert,noselect,popup' },
  preselect = cmp.PreselectMode.None,
  formatting = {
    -- Youtube: How to set up nice formatting for your sources.
    format = lspkind.cmp_format {
      with_text = true,
      menu = {
        buffer = "[Buf]",
        nvim_lsp = "[LSP]",
        path = "[Path]",
        treesitter = "[Tree]",
        ultisnips = "[Ulti]"
      },
    },
  },

  experimental = {
    native_menu = false,
    ghost_text = true,
  }
})

cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources(
  {
    { name = 'nvim_lsp_document_symbol' }
  },
  {
    { name = 'buffer' }
  })
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources(
  {
    { name = 'path' }
  },
  {
    { name = 'cmdline' }
  })
})

-- lsp_signature
lsp_signature_cfg = {
  handler_opts = {
    border = "none"   -- double, single, shadow, none
  },
  extra_trigger_chars = {"(", ","}
}

-- Setup lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- lsp-config
-- vim.lsp.set_log_level("debug")
local nvim_lspconfig = require('lspconfig')

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    --vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    --vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gd', require('goto-preview').goto_preview_definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    --vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gr', telescope_builtin.lsp_references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local lsp_default_config = {capabilties = capabilties}
local servers = {
  jsonls = {},
  yamlls = {
    settings = {
      yaml = {
        schemas = {
          ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
          ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.21.14-standalone-strict/all.json"] = "/*.k8s.yaml",
        },
      },
    }
  },
  terraformls = {},
  ts_ls = {},
  gopls = {
    filetypes = { 'go', 'gomod', 'gohtmltmpl', 'gotexttmpl' },
    cmd = {'gopls','--remote=auto'},
    flags = { allow_incremental_sync = true, debounce_text_changes = 1000 },
    settings = {
      gopls = {
        analyses = { unusedparams = true, unreachable = false },
        codelenses = {
          generate = true, -- show the `go generate` lens.
          gc_details = true, --  // Show a code lens toggling the display of gc's choices.
          test = true,
          tidy = true,
        },
        usePlaceholders = true,
        completeUnimported = true,
        staticcheck = true,
        matcher = 'fuzzy',
        diagnosticsDelay = '500ms',
        symbolMatcher = 'fuzzy',
        gofumpt = false, -- true, -- turn on for new repos, gofmpt is good but also create code turmoils
        buildFlags = { '-tags', 'lint' },
        -- hoverKind = "FullDocumentation",
      },
    },
  },
	golangci_lint_ls = {},
}

for server, config in pairs(servers) do
  nvim_lspconfig[server].setup(vim.tbl_deep_extend('force', lsp_default_config, config))
end

-- devicons
require'nvim-web-devicons'.setup {
 -- globally enable default icons (default to false)
  default = true;
}

-- nvim-treesitter
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true
  },
  indent = {
    enable = true
  }
}

require("catppuccin").setup({
    flavour = "macchiato", -- latte, frappe, macchiato, mocha
    dim_inactive = {
        enabled = true, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
    },
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" }, -- Change the style of comments
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        vimwiki = true,
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
})

vim.cmd("colorscheme catppuccin-macchiato")

require('gitsigns').setup{
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    map('n', '<leader>hs', gs.stage_hunk)
    map('n', '<leader>hr', gs.reset_hunk)
    map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line("."), vim.fn.line("v")} end)
    map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line("."), vim.fn.line("v")} end)
    map('n', '<leader>hS', gs.stage_buffer)
    map('n', '<leader>hu', gs.undo_stage_hunk)
    map('n', '<leader>hR', gs.reset_buffer)
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hb', function() gs.blame_line{full=true} end)
    map('n', '<leader>tb', gs.toggle_current_line_blame)
    map('n', '<leader>hd', gs.diffthis)
    map('n', '<leader>hD', function() gs.diffthis('~') end)
    map('n', '<leader>td', gs.toggle_deleted)

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}

require('goto-preview').setup {}


-- go.nvim
require('go').setup()

local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').goimport()
  end,
  group = format_sync_grp,
})

-- noice.nvim
require("noice").setup({
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = false, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = true, -- add a border to hover docs and signature help
  },
  views = {
    cmdline_popup = {
      position = {
        row = "35%",
        col = "50%",
      },
    },
  },
  routes = {
    {
      view = "mini",
      filter = {
        event = "msg_show",
        kind = "",
        find = "zapisano", -- no comments
      },
    },
  },
})

require('copilot').setup({
  panel = {
 	 enabled = false,
 	 auto_refresh = false,
 	 keymap = {
 		 jump_prev = "[[",
 		 jump_next = "]]",
 		 accept = "<CR>",
 		 refresh = "gr",
 		 open = "<M-CR>"
 	 },
 	 layout = {
 		 position = "bottom", -- | top | left | right
 		 ratio = 0.4
 	 },
  },
  suggestion = {
 	 enabled = false,
 	 auto_trigger = false,
 	 debounce = 75,
 	 keymap = {
 		 accept = "<M-a>",
 		 accept_word = false,
 		 accept_line = false,
 		 next = "<M-]>",
 		 prev = "<M-[>",
 		 dismiss = "<M-c>",
 	 },
  },
  filetypes = {
 	 yaml = false,
 	 markdown = false,
 	 help = false,
 	 gitcommit = false,
 	 gitrebase = false,
 	 hgcommit = false,
 	 svn = false,
 	 cvs = false,
 	 ["."] = false,
  },
  copilot_node_command = 'node', -- Node.js version must be > 18.x
  server_opts_overrides = {},
})

require("CopilotChat").setup {
  --debug = true, -- Enable debugging
  -- See Configuration section for rest
  --
  prompts = {
 	 BetterNamings = "Please provide better names for the following variables and functions.",
  },
  window = {
 	 layout = 'float',
 	 relative = 'editor',
 	 border = 'rounded',
 	 width = 0.9,
 	 height = 0.8,
  }
}

local chat = require("CopilotChat")
vim.keymap.set('n', "<leader>co", chat.toggle, { noremap = true, silent = true })
