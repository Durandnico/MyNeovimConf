local nn = require("notebook-navigator")

nn.setup({
	cell_marker = {
		python = "# %%",
	},
	repl_provider = "molten",
	keys = {
		{
			"]h",
			function()
				require("notebook-navigator").move_cell("d")
			end,
		},
		{
			"[h",
			function()
				require("notebook-navigator").move_cell("u")
			end,
		},
		{ "<leader>X", "<cmd>lua require('notebook-navigator').run_cell()<cr>" },
		{ "<leader>x", "<cmd>lua require('notebook-navigator').run_and_move()<cr>" },
	},
})

vim.keymap.set("n", "<leader>xe", function()
	nn.run_cell()
end)
