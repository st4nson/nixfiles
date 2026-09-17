-- Migrated off nvim-cmp (unmaintained) + LuaSnip; blink bundles engine, sources,
-- snippets and expands via native vim.snippet. Fuzzy matcher built from source
-- (`nix run .#build-plugin`) since the prebuilt release is a dynamic ELF that
-- breaks on NixOS; falls back to the Lua matcher if the build fails.

return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "moyiz/blink-emoji.nvim",
    },
    version = "1.*",
    build = "nix run .#build-plugin",
    event = { "InsertEnter", "CmdlineEnter" },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = "default",

        -- Tab cascade: menu selection > snippet jump > literal fallback.
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<C-y>"] = { "select_and_accept", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<C-n>"] = { "select_next", "show" },

        -- <C-k> is vim.lsp.buf.signature_help in lsp.lua; don't shadow it.
        ["<C-k>"] = {},
      },

      appearance = {
        nerd_font_variant = "mono",
      },

      completion = {
        list = {
          selection = {
            preselect = false,
            auto_insert = false,
          },
        },

        menu = {
          draw = {
            columns = {
              { "kind_icon" },
              { "label", "label_description", gap = 1 },
              { "source_name" },
            },
          },
        },

        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },

        ghost_text = {
          enabled = true,
        },
      },

      sources = {
        default = { "lsp", "path", "snippets", "buffer", "emoji" },

        providers = {
          snippets = {
            min_keyword_length = function(ctx)
              return ctx.trigger.initial_kind == "manual" and 0 or 1
            end,
          },

          -- Run buffer in parallel rather than as an lsp fallback.
          lsp = {
            fallbacks = {},
          },

          buffer = {
            name = "[Buf]",
            min_keyword_length = 3,
          },

          emoji = {
            module = "blink-emoji",
            name = "[Emoji]",
            score_offset = -15,
            opts = { insert = true },
          },
        },
      },

      -- noice.nvim already pops signatures on `(` and `,`.
      signature = { enabled = false },

      cmdline = {
        keymap = {
          preset = "cmdline",
          ["<CR>"] = { "accept_and_enter", "fallback" },
        },
        completion = {
          menu = { auto_show = true },
          list = { selection = { preselect = false, auto_insert = false } },
        },
      },

      fuzzy = {
        implementation = "prefer_rust_with_warning",
      },
    },

    opts_extend = { "sources.default" },
  },

  { "rafamadriz/friendly-snippets", lazy = true },
  { "moyiz/blink-emoji.nvim", lazy = true },
}
