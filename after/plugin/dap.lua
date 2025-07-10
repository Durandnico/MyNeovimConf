-- require("lazydev").setup({
--   library = { "nvim-dap-ui" },
-- })

local dap, dapui = require("dap"), require("dapui")
local widgets = require("dap.ui.widgets")

-- dapui setup
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end

dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end

dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end

dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

-- setup dap for rust
dap.configurations.rust = {
  {
    adapter = "codeLLDB",
    filetypes = { "rust" },
    request = "launch",
    name = "Launch file",
    program = function()

      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
    end,
  },
}

vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
vim.keymap.set('n', '<leader>dc', dap.continue, { desc = "Continue" })
vim.keymap.set('n', '<leader>dus',
function ()
  print("Debugging started")
  print(widgets)
  -- local widgets = dapui.widgets;
  -- print("Widgets: ", widgets)
  local sidebar = widgets.sidebar(widgets.scopes);
  sidebar.open();

end, { desc = "Open scopes" })

vim.keymap.set('n', '<leader>dui', dapui.toggle, { desc = "Toggle UI" })


