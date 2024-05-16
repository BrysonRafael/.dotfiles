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

    -- Copilot
    {
      'zbirenbaum/copilot.lua',
      config = function()
        require('copilot').setup {
          suggestion = { enabled = false },
          panel = { enabled = false },
        }
      end,
    },
    {
      'zbirenbaum/copilot-cmp',
      config = function()
        require('copilot_cmp').setup()
      end,
    },
  },
  config = function()
    local cmp = require 'cmp'
    local lspkind = require 'lspkind'
    local luasnip = require 'luasnip'
    require('luasnip.loaders.from_vscode').lazy_load()
    luasnip.config.setup {}

    local has_words_before = function()
      if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then
        return false
      end
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match '^%s*$' == nil
    end

    cmp.setup {
      formatting = {
        format = lspkind.cmp_format {
          mode = 'symbol',
          maxwidth = 50,
          ellipsis_chat = '...',
          show_labelDetails = true,
          symbol_map = { Copilot = '' },
        },
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = {
        completeopt = 'menu,menuone,noinsert',
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
        ['<Tab>'] = vim.schedule_wrap(function(fallback)
          if cmp.visible() and has_words_before() then
            cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
          else
            fallback()
          end
        end),
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
        { name = 'copilot' },
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'cmp-nvim-lsp-signature-help' },
      },
      sorting = {
        priority_weight = 2,
        comparators = {
          require('copilot_cmp.comparators').prioritize,

          -- Below is the default comparitor list and order for nvim-cmp
          cmp.config.compare.offset,
          -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
          cmp.config.compare.exact,
          cmp.config.compare.score,
          cmp.config.compare.recently_used,
          cmp.config.compare.locality,
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      },
    }
  end,
}
