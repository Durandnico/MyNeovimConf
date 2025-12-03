local conform = require("conform")

local function getCurrentFormatter()
	local status, conform = pcall(require, "conform")
	if not status then
		return "Conform not installed"
	end

	local formatters = conform.list_formatters_for_buffer()
	if formatters and #formatters > 0 then
		return "Formatter: " .. table.concat(formatters, " ")
	end

	local lsp_clients = require("conform.lsp_format").get_format_clients({ bufnr = vim.api.nvim_get_current_buf() })
	if not vim.tbl_isempty(lsp_clients) then
		return "Formatter: LSP"
	end

	return "No formatter available"
end

conform.setup({
	formatters_by_ft = {

		lua = { "stylua" },

		python = { "isort", "black" },

		javascript = { "prettier" },
		typescript = { "prettier" },
		html = { "prettier" },
		css = { "prettier" },
		json = { "prettier" },
		markdown = { "prettier" },

		go = { "gofmt" },
		sh = { "shfmt" },
	},

	format_on_save = {
		timeout_ms = 1000,
		async = false,
		-- lsp_format = "never",
	},
})

local function format_call()
	conform.format({
		lsp_fallback = true,
		async = false,
	})
end

-- print(getCurrentFormatter())
vim.keymap.set({ "n", "v" }, "<leader>f", function()
	format_call()
end, { desc = "Format file or range (in visual mode)" })

vim.keymap.set("n", "<leader>if", function()
	print(getCurrentFormatter())
end, { desc = "Show current formatter" })

vim.api.nvim_create_autocmd({ "BufWritePre" }, { callback = format_call })
