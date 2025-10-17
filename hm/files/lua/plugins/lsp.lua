-- ============================================================================
-- LSP Configuration
-- ============================================================================

return {
  -- ============================================================================
  -- LSP Config
  -- ============================================================================
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "ray-x/lsp_signature.nvim",
      "rmagatti/goto-preview",
    },
    config = function()
      local nvim_lspconfig = require('lspconfig')
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- ======================================================================
      -- LSP Keymaps (set on attach)
      -- ======================================================================
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          local opts = { buffer = ev.buf }
          local telescope_builtin = require('telescope.builtin')

          -- Buffer local mappings
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
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
          vim.keymap.set('n', 'gr', telescope_builtin.lsp_references, opts)
          vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format({ async = true })
          end, opts)
        end,
      })

      -- ======================================================================
      -- LSP Server Configurations
      -- ======================================================================
      local lsp_default_config = { capabilities = capabilities }

      local servers = {
        -- JSON
        jsonls = {},

        -- YAML
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

        -- Terraform
        terraformls = {},

        -- TypeScript/JavaScript
        ts_ls = {},

        -- Go
        gopls = {
          filetypes = { 'go', 'gomod', 'gohtmltmpl', 'gotexttmpl' },
          cmd = { 'gopls', '--remote=auto' },
          flags = {
            allow_incremental_sync = true,
            debounce_text_changes = 1000
          },
          settings = {
            gopls = {
              analyses = {
                unusedparams = true,
                unreachable = false
              },
              codelenses = {
                generate = true,
                gc_details = true,
                test = true,
                tidy = true,
              },
              usePlaceholders = true,
              completeUnimported = true,
              staticcheck = true,
              matcher = 'fuzzy',
              diagnosticsDelay = '500ms',
              symbolMatcher = 'fuzzy',
              gofumpt = false,
              buildFlags = { '-tags', 'lint' },
            },
          },
        },

        -- Golangci-lint
        golangci_lint_ls = {},
      }

      -- Setup all LSP servers
      for server, config in pairs(servers) do
        nvim_lspconfig[server].setup(vim.tbl_deep_extend('force', lsp_default_config, config))
      end
    end,
  },

  -- ============================================================================
  -- LSP Signature
  -- ============================================================================
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      local lsp_signature_cfg = {
        handler_opts = {
          border = "none"
        },
        extra_trigger_chars = { "(", "," }
      }
      require("lsp_signature").setup(lsp_signature_cfg)
    end,
  },

  -- ============================================================================
  -- Goto Preview
  -- ============================================================================
  {
    "rmagatti/goto-preview",
    config = function()
      require('goto-preview').setup({})
    end,
  },

  -- ============================================================================
  -- Treesitter
  -- ============================================================================
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require('nvim-treesitter.configs').setup({
        highlight = {
          enable = true
        },
        indent = {
          enable = true
        }
      })
    end,
  },
}
