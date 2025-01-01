require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = {
    "lua_ls",
    "pyright",
    "eslint",
    "ts_ls",
    "clangd",
  },


  handlers = {
    -- this first function is the "default handler"
    -- it applies to every language server without a "custom handler"
    function(server_name)
      require('lspconfig')[server_name].setup({
        on_attach = function(client, bufnr)
          -- require("mason").on_attach(client, bufnr)
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
        end,
      })
    end,
  }
}
