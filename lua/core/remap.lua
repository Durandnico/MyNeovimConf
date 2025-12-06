-- PrimeTime Neovim remaps
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Exit to folder view" })

vim.keymap.set("v", "<M-Down>", ":m '>+1<CR>gv=gv", { desc = "Move line up" })
vim.keymap.set("v", "<M-j>", ":m '>+1<CR>gv=gv", { desc = "Move line up" })
vim.keymap.set("v", "<M-Up>", ":m '<-2<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv", { desc = "Move line down" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down half page" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up half page" })
vim.keymap.set("n", "n", "nzz", { desc = "Move to next search match and center it" })
vim.keymap.set("n", "N", "Nzz", { desc = "Move to previous search match and center it" })

vim.keymap.set("x", "p", '"_dP', { desc = "Paste without yanking" })

vim.keymap.set("n", "<leader>y", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Copy to system clipboard" })

vim.keymap.set(
	"n",
	"<leader>s",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Replace word under cursor" }
)

-- Mael's stolen remaps
--
-- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>', { desc = "Disable left arrow key" })
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>', { desc = "Disable right arrow key" })
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>', { desc = "Disable up arrow key" })
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>', { desc = "Disable down arrow key" })

-- Keep visual selection after indenting
vim.keymap.set("v", "<", "<gv", { noremap = true, silent = true }, { desc = "Keep selection after indenting" })
vim.keymap.set("v", ">", ">gv", { noremap = true, silent = true }, { desc = "Keep selection after indenting" })

-- My custom remaps
-- nvim-tree
vim.keymap.set("n", "<leader>pv", ":NvimTreeFocus<CR>", { desc = "Toggle file explorer" })
vim.keymap.set("n", "<leader>pc", ":NvimTreeClose<CR>", { desc = "Close file explorer" })

-- Close vim if nvim-tree is the last buffer (after closing a buffer)
-- Thanks to @@beauwilliams
vim.api.nvim_create_autocmd("BufEnter", {
	group = vim.api.nvim_create_augroup("NvimTreeClose", { clear = true }),
	pattern = "NvimTree_*",
	callback = function()
		local layout = vim.api.nvim_call_function("winlayout", {})
		if
			layout[1] == "leaf"
			and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree"
			and layout[3] == nil
		then
			vim.cmd("confirm quit")
		end
	end,
})
