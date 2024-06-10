return {
  -- Autocompletion
  'hrsh7th/nvim-cmp',
  dependencies = {
    {
      'L3MON4D3/LuaSnip',
      version = 'v2.*',
      build = 'make install_jsregexp',
    },
    'saadparwaiz1/cmp_luasnip',

    -- Adds LSP completion capabilities
    'hrsh7th/cmp-nvim-lsp',

    -- Signature help
    'hrsh7th/cmp-nvim-lsp-signature-help',

    -- Completion icons
    'onsails/lspkind.nvim',
  },
  config = function()
    local cmp = require 'cmp'
    local lspkind = require 'lspkind'
    local luasnip = require 'luasnip'
    require('luasnip.loaders.from_vscode').lazy_load()
    luasnip.config.setup {}

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      completion = {
        completeopt = 'menu,menuone,noinsert',
      },

      formatting = {
        format = lspkind.cmp_format {
          mode = 'symbol_text',
          preset = 'codicons',
          before = function(entry, vim_item)
            vim_item.menu = ({
              buffer = '[Buffer]',
              dap = '[DAP]',
              git = '[GitHub]',
              luasnip = '[Snippet]',
              nvim_lsp = '[LSP]',
              nvim_lsp_signature_help = '[Signature]',
              path = '[Path]',
              treesitter = '[Treesitter]',
            })[entry.source.name]

            vim_item.dup = { feature_flipper = 1, nvim_lsp = 0 }

            return vim_item
          end,
        },
      },

      mapping = cmp.mapping.preset.insert {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      },

      sources = {
        { name = 'buffer' },
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'treesitter' },
      },
    }
  end,
}
