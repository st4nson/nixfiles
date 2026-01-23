-- ============================================================================
-- Completion Configuration (nvim-cmp + LuaSnip)
-- ============================================================================

return {
  -- ============================================================================
  -- LuaSnip: Snippet engine (Lua-native, replaces UltiSnips)
  -- ============================================================================
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    event = "InsertEnter",
    config = function()
      -- Load VSCode-format snippets from friendly-snippets
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },

  -- ============================================================================
  -- nvim-cmp: Completion engine
  -- ============================================================================
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "onsails/lspkind.nvim",
    },
    config = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      local luasnip = require("luasnip")

      -- ========================================================================
      -- Main completion setup
      -- ========================================================================
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        mapping = cmp.mapping.preset.insert(),

        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer", keyword_length = 3 },
          { name = "path" },
          { name = "emoji" },
        },

        completion = {
          completeopt = "menu,menuone,noinsert,noselect,popup",
        },

        preselect = cmp.PreselectMode.None,

        formatting = {
          format = lspkind.cmp_format({
            with_text = true,
            menu = {
              buffer = "[Buf]",
              nvim_lsp = "[LSP]",
              path = "[Path]",
              luasnip = "[Snip]",
              emoji = "[Emoji]",
            },
          }),
        },

        experimental = {
          ghost_text = true,
        },
      })

      -- ========================================================================
      -- Cmdline completion for '/' (search)
      -- ========================================================================
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources(
          {
            { name = "nvim_lsp_document_symbol" },
          },
          {
            { name = "buffer" },
          }
        ),
      })

      -- ========================================================================
      -- Cmdline completion for ':' (commands)
      -- ========================================================================
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources(
          {
            { name = "path" },
          },
          {
            { name = "cmdline" },
          }
        ),
      })
    end,
  },

  -- ============================================================================
  -- Additional completion sources (lazy-loaded with nvim-cmp)
  -- ============================================================================
  { "hrsh7th/cmp-nvim-lsp", lazy = true },
  { "hrsh7th/cmp-buffer", lazy = true },
  { "hrsh7th/cmp-path", lazy = true },
  { "hrsh7th/cmp-cmdline", lazy = true },
  { "hrsh7th/cmp-emoji", lazy = true },
  { "hrsh7th/cmp-nvim-lsp-document-symbol", lazy = true },
  { "saadparwaiz1/cmp_luasnip", lazy = true },
  { "onsails/lspkind.nvim", lazy = true },
}
