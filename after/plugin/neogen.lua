local neogen = require("neogen")

neogen.setup({
	enabled = true,
	input_after_comment = true, -- (default: true) automatic jump (with insert mode) on inserted annotation
	languages = {
		python = {
			template = {
				annotation_convention = "google_docstrings", -- for a full list of annotation_conventions, see https://github.com/danymat/neogen
			},
		},
	},
})

-- keymaps
vim.keymap.set("n", "<Leader>nf", function()
	neogen.generate({ snippet_engine = "luasnip" })
end, { noremap = true, silent = true, desc = "add annotation to the file" })
