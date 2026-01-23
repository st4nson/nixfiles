-- ============================================================================
--
-- OpenCode AI Assistant Integration
-- ============================================================================

return {
  -- ============================================================================
  -- Snacks.nvim: UI components for opencode
  -- ============================================================================
  {
    "folke/snacks.nvim",
    opts = {
      input = {},
      picker = {},
      terminal = {},
    },
  },

  -- ============================================================================
  -- OpenCode.nvim: AI assistant integration
  -- ============================================================================
  {
    "NickvanDyke/opencode.nvim",
    dependencies = {
      "folke/snacks.nvim",
    },
    config = function()
      -- Shared command + window opts so `server.start` and the toggle keymap
      -- act on the same snacks.terminal instance.
      local opencode_cmd = "opencode --port"
      ---@type snacks.terminal.Opts
      local snacks_terminal_opts = {
        win = {
          position = "right",
          enter = false,
        },
      }

      ---@type opencode.Opts
      vim.g.opencode_opts = {
        server = {
          start = function()
            require("snacks.terminal").open(opencode_cmd, snacks_terminal_opts)
          end,
        },
      }

      -- Required for buffer auto-reload on edits
      vim.o.autoread = true

      -- Keymaps
      vim.keymap.set({ "n", "x" }, "<leader>a", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask opencode" })
      vim.keymap.set({ "n", "x" }, "<leader>x", function() require("opencode").select() end, { desc = "Execute opencode action" })
      vim.keymap.set("n", "<leader>co", function() require("snacks.terminal").toggle(opencode_cmd, snacks_terminal_opts) end, { desc = "Toggle opencode" })

      -- Operator mappings for adding ranges to opencode
      vim.keymap.set({ "n", "x" }, "go", function() return require("opencode").operator("@this ") end, { desc = "Add range to opencode", expr = true })
      vim.keymap.set("n", "goo", function() return require("opencode").operator("@this ") .. "_" end, { desc = "Add line to opencode", expr = true })

      -- Scroll opencode
      vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end, { desc = "Scroll opencode up" })
      vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end, { desc = "Scroll opencode down" })

    end,
  },
}
