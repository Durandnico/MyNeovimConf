require("mason").setup()
require("mason-lspconfig").setup{
	ensure_installed = {
		"lua_ls",
		"pyright",
		"eslint",
		"ts_ls",
},

	handlers = {
		-- this first function is the "default handler"
		-- it applies to every language server without a "custom handler"
		function(server_name)
			require('lspconfig')[server_name].setup({})
		end,
	}
}

