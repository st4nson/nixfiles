return {
  -- neovim
  "nvim-treesitter/nvim-treesitter",
  "nvim-lua/plenary.nvim",
  "nvim-lua/popup.nvim",
  "nvim-telescope/telescope.nvim",
  "nvim-telescope/telescope-ui-select.nvim",
  "folke/noice.nvim",
  "MunifTanjim/nui.nvim",
  "rcarriga/nvim-notify",

  -- completion & lsp
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-emoji",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lsp-document-symbol",
  "hrsh7th/cmp-nvim-lsp-signature-help",
  "hrsh7th/cmp-nvim-lua",
  "quangnguyen30192/cmp-nvim-ultisnips",
  "hrsh7th/cmp-path",
  "ray-x/cmp-treesitter",

  "neovim/nvim-lspconfig",
  "onsails/lspkind.nvim",
  "ray-x/lsp_signature.nvim",
  "rmagatti/goto-preview",

  -- git
  "tpope/vim-fugitive",
  "lewis6991/gitsigns.nvim",

  -- themes
  "nvim-lualine/lualine.nvim",
  "akinsho/bufferline.nvim",
  "nvim-tree/nvim-web-devicons",
  "catppuccin/nvim",

  -- motion
  "preservim/nerdcommenter",
  "nvim-tree/nvim-tree.lua",
  "qpkorr/vim-bufkill",
  "easymotion/vim-easymotion",
  "voldikss/vim-floaterm",
  "jeffkreeftmeijer/vim-numbertoggle",
  "tpope/vim-surround",

  -- programming
  "zbirenbaum/copilot.lua",
  {
    "zbirenbaum/copilot-cmp",
    config = function ()
      require("copilot_cmp").setup()
    end
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    --build = "make tiktoken", -- Only on MacOS or Linux
    --opts = {
      ---- See Configuration section for options
    --},
    -- See Commands section for default commands if you want to lazy load on them
  },
  "ray-x/go.nvim",
  "ray-x/guihua.lua",
  "mfussenegger/nvim-dap",
  "leoluz/nvim-dap-go",
  "theHamsta/nvim-dap-virtual-text",
  "rcarriga/nvim-dap-ui",
  "nvim-neotest/nvim-nio",
  "SirVer/ultisnips",
  "LnL7/vim-nix",
  "honza/vim-snippets",
  "vim-test/vim-test",

  -- misc
  "direnv/direnv.vim",
  "iamcco/markdown-preview.nvim",
  "norcalli/nvim-colorizer.lua",
  "ntpeters/vim-better-whitespace",
  "tpope/vim-dispatch",
  "radenling/vim-dispatch-neovim",
  "jpalardy/vim-slime",
  "vimwiki/vimwiki",
}
