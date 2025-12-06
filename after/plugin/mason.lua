local present, mason = pcall(require, "mason")

if not present then
	return
end

local pres, masonRegister = pcall(require, "mason-registry")

if not pres then
	return
end

local options = {
	ensure_installed = {
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

		-- go
		"gopls", -- lsp
		"goimports-reviser", -- code action
		-- "delve", -- debugger
		"revive", -- linter
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

-- vim.cmd("MasonInstallAll")
