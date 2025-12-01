-- setup lsp
require("mason").setup()
require("mason-lspconfig").setup()


local fixMasonName =
{
  ["lua-language-server"] = "lua_ls"
}

local function getMasonLSP()
  local registry = require("mason-registry")
  local lsp = {}
  for _, pkg_info in ipairs(registry.get_installed_packages()) do
    for _, type in ipairs(pkg_info.spec.categories) do
      if type == "LSP" then
        local lspname = pkg_info.name
        if fixMasonName[lspname] ~= nil then
          lspname = fixMasonName[lspname]
        end
        table.insert(lsp, lspname)
      end
    end
  end
  return lsp
end

for _k, lsp_name in pairs(getMasonLSP()) do
  vim.lsp.config[lsp_name] =
  {
    on_attach = function(client, bufnr)
      print("") -- because the first print sometimes get ignored (idk why)
      print("LSP started for " .. client.name)

      local opts = { buffer = bufnr, remap = false, desc = "" }

      opts.desc = "Goto definition"
      vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts, 'Goto definition')

      opts.desc = "Goto type definition"
      vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)

      opts.desc = "open diagnostics"
      vim.keymap.set('n', '<leader>vd', function() vim.lsp.diagnostic.open_float() end, opts)

      opts.desc = "next diagnostic"
      vim.keymap.set('n', '[d', function() vim.lsp.diagnostic.goto_next() end, opts)

      opts.desc = "previous diagnostic"
      vim.keymap.set('n', ']d', function() vim.lsp.diagnostic.goto_prev() end, opts)

      opts.desc = "vim code action"
      vim.keymap.set('n', '<leader>vca', function() vim.lsp.buf.code_action() end, opts)

      opts.desc = "vim references"
      vim.keymap.set('n', '<leader>vrr', function() vim.lsp.buf.references() end, opts)

      opts.desc = "vim rename"
      vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end, opts)

      opts.desc = "vim signature help"
      vim.keymap.set('n', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)

      opts.desc = "get LSP info"
      vim.keymap.set('n', '<leader>vli', function() print("Current LSP: " .. client.name) end, opts)
    end,
  }
end


-- extend config
vim.lsp.config('gopls', {
  cmd = { "gopls" },

  root_markers = { "go.mod", "go.word", ".git" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },

  settings = {
    gopls = {
      completeUnimported = true,

      analyses = {
        unusedparams = true,
      },

      staticcheck = true,
    },
  },
})


vim.lsp.config('clangd', {
  cmd = { "clangd", "--background-index" },
  filetypes = { "c", "cpp", "h", "hpp", "cc", "hh", "cxx", "hxx" },

  root_markers = { "compile_commands.json", ".git", "Makefile", "CMakeLists.txt" },

  init_options = {
    clangdFileStatus = true,
  },

  settings = {
    clangd = {
      completeUnimported = true,

      analyses = {
        unusedparams = true,
      },

      staticcheck = true,
    },
  },
})
