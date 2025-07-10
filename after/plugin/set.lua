-- get current buffer file type
local function get_filetype()
	return vim.api.nvim_buf_get_option(0, 'filetype')
end

-- if filetype is python, then set tabstop, softtabstop, shiftwidth to 4
if get_filetype() == 'python' or get_filetype() == 'py' then
	vim.opt.tabstop = 4
	vim.opt.softtabstop = 4
	vim.opt.shiftwidth = 4
end
