-- list of styles:
-- rmarkdown, nomarker, pandoc, markdown, marimo, myst, spin, sphinx, quarto, light, hydrogen, percent

require("jupytext").setup({

	-- style = "hydrogen",
	style = "percent",
	output_extension = "auto", -- Default extension. Don't change unless you know what you are doing
	force_ft = nil, -- Default filetype. Don't change unless you know what you are doing

	-- custom_language_formatting = {
	-- 	python = {
	-- 		extension = "qmd",
	-- 		style = "quarto",
	-- 		force_ft = "quarto",
	-- 	},
	-- },
	-- r = {
	-- 	extension = "qmd",
	-- 	style = "quarto",
	-- 	force_ft = "quarto",
	-- },
	-- },

	-- style = "markdown",
	-- output_extension = "md",
	-- force_ft = "markdown",
})
