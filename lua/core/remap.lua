vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Exit to folder view" })

vim.keymap.set("v", "<M-Down>", ":m '>+1<CR>gv=gv", { desc = "Move line up" })
vim.keymap.set("v", "<M-Up>", ":m '<-2<CR>gv=gv", { desc = "Move line down" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down half page" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up half page" })
vim.keymap.set("n", "n", "nzz", { desc = "Move to next search match and center it" })
vim.keymap.set("n", "N", "Nzz", { desc = "Move to previous search match and center it" })

vim.keymap.set("x", "p", '"_dP', { desc = "Paste without yanking" })

vim.keymap.set("n", "<leader>y", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Copy to system clipboard" })

-- old formatting keymap
-- vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { desc = "format file" })

vim.keymap.set(
	"n",
	"<leader>s",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Replace word under cursor" }
)

-- vim.api.nvim_create_autocmd({ "BufWritePre" }, { callback = vim.lsp.buf.format})
