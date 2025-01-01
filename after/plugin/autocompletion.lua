local cmp = require('cmp')
require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
    {name = 'buffer'},
    {name = 'path'},
    {name = 'luasnip'},
    {name = 'nvim_lua'},
  },

  mapping = {
    ['<Down>'] = cmp.mapping.select_next_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),

    ['<Up>'] = cmp.mapping.select_prev_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),

    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),


    -- Simple tab complete
    ['<Tab>'] = cmp.mapping(function(fallback)
	    local col = vim.fn.col('.') - 1

	    if cmp.visible() then
		    cmp.select_next_item({behavior = 'select'})
	    elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
		    fallback()
	    else
		    cmp.complete()
	    end
    end, {'i', 's'}),

    -- Go to previous item
    ['<S-Tab>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
  },

  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },

  preselect = 'item',
  completion = {
    completeopt = 'menu,menuone,noinsert',
  },

})
