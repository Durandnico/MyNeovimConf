-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			",	",
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
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
			"nvim-telescope/telescope.nvim",
			dependencies = { "nvim-lua/plenary.nvim" }, -- <-- this idk what it does
		},

		-- color theme
		{
			"catppuccin/nvim",
			name = "catppuccin",
			config = function()
				vim.cmd("colorscheme catppuccin-frappe")
			end,
		},

		-- colorized code keyword
		{
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
		},

		-- mason : external package manager such as lsp/linter
		{
			"williamboman/mason.nvim",
			cmd = "Mason",
		},

		{
			"williamboman/mason-lspconfig.nvim",
			dependencies = {
				"williamboman/mason.nvim",
			},
			event = { "BufReadPre", "BufNewFile" },
		},

		-- lsp config
		{
			"neovim/nvim-lspconfig",
		},

		-- Autocompletion
		{
			"hrsh7th/nvim-cmp",
			dependencies = {
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"saadparwaiz1/cmp_luasnip",
				"hrsh7th/cmp-nvim-lua",
			},
			event = "InsertEnter",
		},

		-- Snippets
		{
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
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

		-- formatter
		{
			"stevearc/conform.nvim",
			event = { "BufReadPre", "BufNewFile" },
		},

		-- linter
		{
			"mfussenegger/nvim-lint",
			event = { "BufReadPre", "BufNewFile" },
		},

		-- nvim tree
		{
			"nvim-tree/nvim-tree.lua",
			lazy = false,
			dependencies = {
				"nvim-tree/nvim-web-devicons", -- optional, for file icons
			},
		},
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "catppuccin" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
	-- automatically clean unused plugins
	clean = true,
	-- autoupdate plugins
	update = "daily",
})
