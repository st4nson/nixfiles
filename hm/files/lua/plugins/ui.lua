-- ============================================================================
-- UI Plugins Configuration
-- ============================================================================

return {
  -- ============================================================================
  -- Colorscheme: Catppuccin
  -- ============================================================================
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "macchiato", -- latte, frappe, macchiato, mocha
        dim_inactive = {
          enabled = true,
          shade = "dark",
          percentage = 0.15,
        },
        styles = {
          comments = { "italic" },
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
        },
      })

      -- Set colorscheme
      vim.cmd("colorscheme catppuccin-macchiato")
    end,
  },

  -- ============================================================================
  -- Status Line: Lualine
  -- ============================================================================
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require('lualine').setup({
        options = {
          theme = 'catppuccin-macchiato'
        },
      })
    end,
  },

  -- ============================================================================
  -- Buffer Line
  -- ============================================================================
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({
        options = {
          diagnostics = "nvim_lsp",
        }
      })
    end,
  },

  -- ============================================================================
  -- Dev Icons
  -- ============================================================================
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require('nvim-web-devicons').setup({
        default = true,
      })
    end,
  },

  -- ============================================================================
  -- Colorizer
  -- ============================================================================
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require('colorizer').setup()
    end,
  },

  -- ============================================================================
  -- Noice: Better UI for messages, cmdline and popupmenu
  -- ============================================================================
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        presets = {
          bottom_search = false,
          command_palette = true,
          long_message_to_split = true,
          inc_rename = false,
          lsp_doc_border = true,
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
              find = "zapisano", -- Polish for "saved"
            },
          },
        },
      })
    end,
  },
}
