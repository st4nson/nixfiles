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
      "rmagatti/goto-preview",
      "b0o/schemastore.nvim",
    },
    config = function()
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
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          -- Manual signature trigger; auto-popup is handled by noice.nvim on `(` and `,`.
          -- Bound in normal + insert mode so you can re-summon without leaving insert.
          vim.keymap.set({ 'n', 'i' }, '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', 'gr', telescope_builtin.lsp_references, opts)
          vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format({ async = true })
          end, opts)
          vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
        end,
      })

      -- ======================================================================
      -- LSP Server Configurations
      -- ======================================================================
      local lsp_default_config = { capabilities = capabilities }

      local servers = {
        -- JSON
        jsonls = {
          settings = {
            json = {
              schemas = require("schemastore").json.schemas(),
              validate = { enable = true },
            },
          },
        },

        -- YAML
        yamlls = {
          settings = {
            yaml = {
              -- Disable built-in schema store fetch; use bundled catalog from schemastore.nvim
              schemaStore = {
                enable = false,
                url = "",
              },
              schemas = vim.tbl_extend("force",
                require("schemastore").yaml.schemas(),
                {
                  -- Bundled k8s schema from yaml-language-server itself.
                  -- Updates when the Nix yaml-language-server package updates.
                  kubernetes = {
                    "*.k8s.yaml",
                    "*.k8s.yml",
                    "**/kubectl-edit-*.yaml",
                  },
                }
              ),
              keyOrdering = false,
            },
          },
        },

        -- Lua (for editing Neovim config itself)
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              diagnostics = { globals = { "vim" } },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
              },
              telemetry = { enable = false },
            },
          },
        },

        -- Terraform
        terraformls = {
          settings = {
            terraformls = {
              indexing = {
                -- Ignore .terraform directories to prevent recursive module walking
                ignorePaths = { ".terraform" },
                ignoreDirectoryNames = { ".terraform", "examples", "tests" },
              },
            },
          },
        },

        -- TypeScript/JavaScript
        ts_ls = {},

        -- Go
        gopls = {
          filetypes = { 'go', 'gomod', 'gohtmltmpl', 'gotexttmpl' },
          cmd = { 'gopls', '--remote=auto' },
          flags = {
            allow_incremental_sync = true,
            debounce_text_changes = 500,
          },
          settings = {
            gopls = {
              -- Directory filters to exclude from workspace scanning
              directoryFilters = {
                "-**/.git",
                "-**/.testenv",
                "-**/bin",
                "-**/node_modules",
                "-**/.direnv",
              },
              analyses = {
                unusedparams = true,
                unreachable = false,
              },
              codelenses = {
                generate = true,
                gc_details = false,  -- Disable for performance
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
              -- Memory optimization
              memoryMode = 'DegradeClosed',
            },
          },
        },
      }

      -- Setup all LSP servers
      for server, config in pairs(servers) do
        vim.lsp.config(server, vim.tbl_deep_extend('force', lsp_default_config, config))
        vim.lsp.enable(server)
      end
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
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({
          "bash",
          "css",
          "diff",
          "dockerfile",
          "gitcommit",
          "gitignore",
          "go",
          "gomod",
          "gosum",
          "gowork",
          "hcl",
          "html",
          "javascript",
          "json",
          "jsonc",
          "lua",
          "markdown",
          "markdown_inline",
          "nix",
          "query",
          "regex",
          "terraform",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "yaml",
      })
    end,
  },
  {
      "towolf/vim-helm"
  }
}
