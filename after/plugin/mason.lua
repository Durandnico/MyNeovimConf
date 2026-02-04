local mason = require("mason")

local masonRegister = require("mason-registry")

local options = {
	ensure_installed = {
		-- vim
		"vim-language-server",

		-- lua
		-- "lua-language-server", -- lsp
		-- fix : issue with newer version of libbfd-2.38+, so pin to 3.15.0 for now
		"lua-language-server@3.15.0",
		"stylua", -- formatter

		-- bash
		"shfmt ", -- formatter

		-- python
		"pyright", -- lsp
		"isort", -- import sorter
		"black", -- formatter
		"ruff", -- linter

		-- cpp
		"clangd", -- lsp
		"codelldb", -- debugger

		-- typescript
		"prettierd", -- formatter
		"eslint_d", -- linter
		"typescript-language-server", -- lsp

		-- not really using go
		-- go
		-- "gopls", -- lsp
		-- "goimports-reviser", -- code action
		-- "delve", -- debugger
		-- "revive", -- linter

		-- tools
		"tree-sitter-cli",
	},
	max_concurrent_installers = 10,
}

mason.setup(options)

vim.api.nvim_create_user_command("MasonInstallAll", function()
	-- check if plugin is already ensure_installed
	for _, plugin in ipairs(options.ensure_installed) do
		if not masonRegister.is_installed(plugin) then
			vim.cmd("MasonInstall " .. table.concat({ plugin }, " "))
		end
	end
end, {})
