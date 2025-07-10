-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({ ",	",
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
-- vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {


    -- fuzzy finder file
    {
      'nvim-telescope/telescope.nvim',
      tag = '0.1.8',
      -- or                              , branch = '0.1.x',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },


    -- color theme
    {
      "catppuccin/nvim",
      name = "catppuccin",
      priority = 1000,
      config = function()
        vim.cmd("colorscheme catppuccin-frappe")
      end
    },

    -- colorized code keyword
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate"
    },

    -- mason : external package manager such as lsp/linter
    {
      "williamboman/mason.nvim",
      lazy = false,
      config = function()
        require("mason").setup()
      end
    },

    {
      "williamboman/mason-lspconfig.nvim",
      lazy = false,
      config = function()
        require("mason-lspconfig").setup({
          ensure_installed = {
            -- "lua_ls",

          }
        })
      end,
    },

    -- lsp config
    {
      "neovim/nvim-lspconfig",
    },

    -- zero-lsp
    -- TODO : setup this thing (/after/plugins/lsp)
    {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v4.x',
      dependencies = {
        -- LSP Support
        { 'neovim/nvim-lspconfig' }, -- Required

        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },         -- Required
        { 'hrsh7th/cmp-nvim-lsp' },     -- Required
        { 'hrsh7th/cmp-buffer' },       -- Optional
        { 'hrsh7th/cmp-path' },         -- Optional
        { 'saadparwaiz1/cmp_luasnip' }, -- Optional
        { 'hrsh7th/cmp-nvim-lua' },     -- Optional

        -- Snippets
        { 'L3MON4D3/LuaSnip' },             -- Optional
        { 'rafamadriz/friendly-snippets' }, -- Optional
      },
    },

    -- which-key
    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      },
      keys = {
        {
          "<leader>?",
          function()
            require("which-key").show({ global = false })
          end,
          desc = "Buffer Local Keymaps (which-key)",
        },
      },
    },

    -- copilot
    {
      "github/copilot.vim",
    },

    -- dap
    {
      "mfussenegger/nvim-dap",
      event = "VeryLazy",
    },
    {
      "rcarriga/nvim-dap-ui",
      dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" }
    },

    -- rust
    {
      "rust-lang/rust.vim",
      ft = "rust",
      config = function()
        vim.g.rustfmt_autosave = 1
        -- vim.g.rustfmt_fail_silently = 1
        -- vim.g.rust_fold = 1
        -- vim.g.rust_clip_command = "xclip -selection clipboard"
      end,
    },

    {
      "simrat39/rust-tools.nvim",
      ft = "rust",
      dependencies = { "neovim/nvim-lspconfig" },
    },

    -- avante.nvim, my maybe futur vibe code goto in life
    -- {
    --   "yetone/avante.nvim",
    --   event = "VeryLazy",
    --   version = false, -- Never set this value to "*"! Never!
    --   opts = {
    --     -- add any opts here
    --     -- for example
    --     provider = "copilot",
    --     copilot = {
    --       model = "claude-3.7-sonnet", -- your desired model (or use gpt-4o, etc.)
    --       timeout = 60000, -- Timeout in milliseconds, increase this for reasoning models
    --       temperature = 0,
    --       max_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
    --       reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
    --     },
    --   },
    --   -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    --   build = "make",
    --   -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    --   dependencies = {
    --     "nvim-treesitter/nvim-treesitter",
    --     "stevearc/dressing.nvim",
    --     "nvim-lua/plenary.nvim",
    --     "MunifTanjim/nui.nvim",
    --     --- The below dependencies are optional,
    --     "echasnovski/mini.pick",     -- for file_selector provider mini.pick
    --     "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    --     "hrsh7th/nvim-cmp",          -- autocompletion for avante commands and mentions
    --     "ibhagwan/fzf-lua",          -- for file_selector provider fzf
    --     "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    --     "zbirenbaum/copilot.lua",    -- for providers='copilot'
    --     {
    --       -- support for image pasting
    --       "HakonHarnes/img-clip.nvim",
    --       event = "VeryLazy",
    --       opts = {
    --         -- recommended settings
    --         default = {
    --           embed_image_as_base64 = false,
    --           prompt_for_file_name = false,
    --           drag_and_drop = {
    --             insert_mode = true,
    --           },
    --           -- required for Windows users
    --           use_absolute_path = true,
    --         },
    --       },
    --     },
    --     {
    --       -- Make sure to set this up properly if you have lazy=true
    --       'MeanderingProgrammer/render-markdown.nvim',
    --       opts = {
    --         file_types = { "markdown", "Avante" },
    --       },
    --       ft = { "markdown", "Avante" },
    --     },
    --   },
    -- }

  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "catppuccin" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
