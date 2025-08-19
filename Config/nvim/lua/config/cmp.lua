-- nvim-cmp setup
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    -- You can configure the snippet engine here (using LuaSnip)
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For LuaSnip
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },        -- LSP completions
    { name = 'luasnip' },         -- LuaSnip completions
  }, {
    { name = 'buffer' },          -- Buffer completions (for non-LSP text)
    { name = 'path' },            -- File path completions
  }),
  -- Formatting (optional)
  formatting = {
    fields = { "abbr", "kind", "menu" },
    format = function(entry, vim_item)
      vim_item.kind = string.format('%s', vim_item.kind)
      return vim_item
    end,
  },
})

-- Enable completion for LSP
local capabilities = require('cmp_nvim_lsp').default_capabilities()
