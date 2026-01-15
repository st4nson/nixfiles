-- ============================================================================
-- Completion Configuration (nvim-cmp)
-- ============================================================================

return {
  -- ============================================================================
  -- LSP Kind: Icons for completion menu
  -- ============================================================================
  {
    "onsails/lspkind.nvim",
    config = function()
      local lspkind = require("lspkind")
      lspkind.init()
    end,
  },

  -- ============================================================================
  -- nvim-cmp: Completion engine
  -- ============================================================================
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "quangnguyen30192/cmp-nvim-ultisnips",
      "onsails/lspkind.nvim",
      "SirVer/ultisnips",
      "honza/vim-snippets",
    },
    config = function()
      local cmp = require('cmp')
      local lspkind = require("lspkind")

      -- ========================================================================
      -- Main completion setup
      -- ========================================================================
      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
          end,
        },

        mapping = cmp.mapping.preset.insert(),

        sources = {
          { name = 'nvim_lsp' },
          { name = 'ultisnips' },
          { name = 'buffer', keyword_length = 3 },
          { name = 'path' },
          { name = 'emoji' }
        },

        completion = {
          completeopt = 'menu,menuone,noinsert,noselect,popup'
        },

        preselect = cmp.PreselectMode.None,

        formatting = {
          format = lspkind.cmp_format({
            with_text = true,
            menu = {
              buffer = "[Buf]",
              nvim_lsp = "[LSP]",
              path = "[Path]",
              treesitter = "[Tree]",
              ultisnips = "[Ulti]"
            },
          }),
        },

        experimental = {
          native_menu = false,
          ghost_text = true,
        }
      })

      -- ========================================================================
      -- Cmdline completion for '/' (search)
      -- ========================================================================
      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources(
          {
            { name = 'nvim_lsp_document_symbol' }
          },
          {
            { name = 'buffer' }
          }
        )
      })

      -- ========================================================================
      -- Cmdline completion for ':' (commands)
      -- ========================================================================
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources(
          {
            { name = 'path' }
          },
          {
            { name = 'cmdline' }
          }
        )
      })
    end,
  },

  -- ============================================================================
  -- Additional completion sources
  -- ============================================================================
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-emoji",
  "hrsh7th/cmp-nvim-lsp-document-symbol",
  "hrsh7th/cmp-nvim-lsp-signature-help",
  "hrsh7th/cmp-nvim-lua",
  "quangnguyen30192/cmp-nvim-ultisnips",
  "ray-x/cmp-treesitter",

  -- ============================================================================
  -- Snippets
  -- ============================================================================
  "SirVer/ultisnips",
  "honza/vim-snippets",
}
