-- ============================================================================
-- GitHub Copilot Configuration
-- ============================================================================

return {
  -- ============================================================================
  -- Copilot: AI pair programmer
  -- ============================================================================
  {
    "zbirenbaum/copilot.lua",
  },

  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end
  },

  -- ============================================================================
  -- CopilotChat: Chat interface for Copilot
  -- ============================================================================
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    config = function()
      require("CopilotChat").setup({
        model = 'gpt-5',
        temperature = 0.2,

        window = {
          layout = 'float',
          relative = 'editor',
          border = 'rounded',
          width = 0.9,
          height = 0.8,
        },

        headers = {
          user = '👤 You',
          assistant = '🤖 Copilot',
          tool = '🔧 Tool',
        },

        separator = '━━',
        auto_fold = true,

        prompts = {
          BetterNamings = {
            prompt = "Please provide better names for the following variables and functions.",
          },
          CustomCommit = {
            prompt = [[
You are a commit message generator. Output only the commit message.
Format:
<type>(scope?): <imperative, concise subject <= 72 chars>
<blank line>
Optional body as bullet list (each line starts with "- ") wrapped at 72 chars.
Bullets describe changes and reasons (what/why, not how). Order most important first.
If single trivial change, omit body.
Reference issues with "closes #ID" as a final bullet.
Types: feat, fix, refactor, perf, docs, test, chore, build, ci, style.
Infer scope from changed paths (e.g. cli, api, config).
No trailing period in subject. No emojis. Be specific and minimal.
            ]],
            resources = {
              'gitdiff:staged',
            },
          },
        }
      })
    end,
  },
}
