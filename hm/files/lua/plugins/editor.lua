-- ============================================================================
-- Editor Plugins Configuration
-- ============================================================================

return {
  -- ============================================================================
  -- File Tree: NvimTree
  -- ============================================================================
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require('nvim-tree').setup({
        renderer = {
          indent_markers = {
            enable = true,
          },
        },
      })
    end,
  },

  -- ============================================================================
  -- Telescope: Fuzzy Finder
  -- ============================================================================
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-lua/popup.nvim",
    },
    config = function()
      -- Helper function to select one or multiple files
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

      require('telescope').setup({
        defaults = {
          prompt_prefix = "🔍",
          mappings = {
            i = {
              ['<CR>'] = select_one_or_multi,
            }
          }
        }
      })
    end,
  },

  -- ============================================================================
  -- Telescope UI Select
  -- ============================================================================
  {
    "nvim-telescope/telescope-ui-select.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension("ui-select")
    end,
  },

  -- ============================================================================
  -- Floating Terminal: Floaterm
  -- ============================================================================
  {
    "voldikss/vim-floaterm",
    config = function()
      vim.g.floaterm_autoclose = 1  -- Close window on success
      vim.g.floaterm_autohide = 2   -- Always autohide
      vim.g.floaterm_width = 0.9
      vim.g.floaterm_height = 0.8
      vim.g.floaterm_borderchars = "─│─│╭╮╯╰"
      
      -- Set floating window border line color
      vim.api.nvim_set_hl(0, 'FloatermBorder', { bg = '#2e3440', fg = '#81a1c1' })
    end,
  },

  -- ============================================================================
  -- Vim Test
  -- ============================================================================
  {
    "vim-test/vim-test",
    config = function()
      vim.cmd([[
function! CustomFloatermStrategy(cmd)
  execute 'FloatermNew --name=vim-test --autoclose=0 --height=0.4 --width=0.6 --wintype=float --position=topright '.a:cmd
endfunction

let g:test#custom_strategies = {'custom_floaterm': function('CustomFloatermStrategy')}
let g:test#strategy = 'custom_floaterm'
      ]])
    end,
  },

  -- ============================================================================
  -- Vim Slime: Send code to REPL
  -- ============================================================================
  {
    "jpalardy/vim-slime",
    config = function()
      local slime_paste = vim.fn.stdpath("state") .. "/slime_paste"
      vim.fn.mkdir(slime_paste, "p")
      vim.g.slime_target = "tmux"
      vim.g.slime_paste_file = slime_paste
      vim.g.slime_dont_ask_default = 1
      vim.g.slime_default_config = {
        socket_name = "default",
        target_pane = ":.1",
      }
    end,
  },

  -- ============================================================================
  -- Buffer Management
  -- ============================================================================
  {
    "qpkorr/vim-bufkill",
  },

  -- ============================================================================
  -- Motion Plugins
  -- ============================================================================
  {
    "easymotion/vim-easymotion",
  },

  {
    "tpope/vim-surround",
  },

  {
    "preservim/nerdcommenter",
  },

  {
    "jeffkreeftmeijer/vim-numbertoggle",
  },

  -- ============================================================================
  -- Utilities
  -- ============================================================================
  {
    "ntpeters/vim-better-whitespace",
  },

  {
    "tpope/vim-dispatch",
  },

  {
    "radenling/vim-dispatch-neovim",
  },

  {
    "direnv/direnv.vim",
  },

  -- ============================================================================
  -- Markdown Preview
  -- ============================================================================
  {
    "iamcco/markdown-preview.nvim",
  },

  -- ============================================================================
  -- VimWiki
  -- ============================================================================
  {
    "vimwiki/vimwiki",
    init = function()
      vim.g.vimwiki_table_mappings = 0
      vim.g.vimwiki_list = {
        {
          path = '~/.vimwiki/work',
          syntax = 'markdown',
          ext = '.md',
        },
        {
          path = '~/.vimwiki/personal',
          syntax = 'markdown',
          ext = '.md',
        }
      }
    end
  },
}
