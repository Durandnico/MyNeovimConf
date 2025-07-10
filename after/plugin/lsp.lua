-- setup lsp
local lspconfig = require('lspconfig')
lspconfig.gopls.setup({
  cmd = { "gopls" },

  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = lspconfig.util.root_pattern("go.mod", "go.word", ".git"),

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


lspconfig.clangd.setup({
  cmd = { "clangd", "--background-index" },
  filetypes = { "c", "cpp", "h", "hpp", "cc", "hh", "cxx", "hxx" },

  root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git", "Makefile", "CMakeLists.txt"),

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


-- rust lsp but with rust-tool
local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})


-- lspconfig.rust_analyzer.setup({
--   cmd = { "rust-analyzer" },
--   filetypes = { "rust" },
--
--   root_dir = lspconfig.util.root_pattern("Cargo.toml", ".git"),
--
--   settings = {
--     ["rust-analyzer"] = {
--       cargo = {
--         allFeatures = true,
--         checkOnSave = {
--           command = "clippy",
--           extraArgs = { "--all-targets", "--all-features" },
--         },
--       },
--       checkOnSave = {
--         command = "clippy",
--       },
--     },
--   },
-- })
--


require("mason").setup()
require("mason-lspconfig").setup {

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

