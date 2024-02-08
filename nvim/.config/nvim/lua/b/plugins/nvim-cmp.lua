return {
  -- Autocompletion
  "hrsh7th/nvim-cmp",
  dependencies = {
    -- Snippet Engine & its associated nvim-cmp source
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",

    -- Adds LSP completion capabilities
    "hrsh7th/cmp-nvim-lsp",
    "FelipeLema/cmp-async-path",

    -- Buffer words
    "hrsh7th/cmp-buffer",

    -- Signature help
    "hrsh7th/cmp-nvim-lsp-signature-help",

    -- Adds a number of user-friendly snippets
    "rafamadriz/friendly-snippets",

    -- Rails fixtures
    { "wassimk/cmp-rails-fixture-types", version = "*", ft = "ruby" },
    { "wassimk/cmp-rails-fixture-names", version = "*", ft = "ruby" },

    -- Flipper gem
    { "wassimk/cmp-feature-flipper", version = "*" },

    -- Gitmojis for commit messages
    { "Dynge/gitmoji.nvim", dependencies = { "hrsh7th/nvim-cmp", }, opts = {}, ft = "gitcommit" },
  },
  config = function()
    local cmp = require "cmp"
    local luasnip = require "luasnip"
    require("luasnip.loaders.from_vscode").lazy_load()
    luasnip.config.setup {}

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = {
        completeopt = "menu,menuone,noinsert",
      },
      mapping = cmp.mapping.preset.insert {
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete {},
        ["<CR>"] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      },
      sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "async_path" },
        { name = "rails-fixture-names" },
        { name = "rails-fixture-types" },
        { name = "feature-flipper" },
        { name = "buffer" },
        { name = "cmp-nvim-lsp-signature-help" },
        { name = "gitmoji" },
      },
    }
  end
}