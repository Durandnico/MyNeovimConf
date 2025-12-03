local lint = require("lint")

-- setup linters
lint.linters_by_ft = {

	javascript = { "eslint_d" },
	typescript = { "eslint_d" },

	python = { "ruff" },

	go = { "revive" },
}

-- setup autocmd to lint automatically kinda anytime
local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	group = lint_augroup,
	callback = function()
		lint.try_lint()
	end,
})

local function getCurrentLinter()
	local ft = vim.bo.filetype
	local linters = lint.linters_by_ft[ft]
	if linters and #linters > 0 then
		return "Linter: " .. table.concat(linters, " ")
	end
	return "No linter available"
end

vim.keymap.set("n", "<leader>il", function()
	print(getCurrentLinter())
end, { desc = "Show current linter" })
