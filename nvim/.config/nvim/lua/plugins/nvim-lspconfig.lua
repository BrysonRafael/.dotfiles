return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    opts.diagnostics.underline = false

    opts.inlay_hints.enabled = false

    opts.servers = vim.tbl_deep_extend("force", opts.servers, {
      ruby_lsp = {
        mason = false,
        cmd_env = {
          GEM_HOME = vim.env.RUBY_CONFDIR,
        },
        init_options = {
          formatter = "rubocop",
          linters = { "rubocop" },
        },
      },
      syntax_tree = {
        mason = false,
        cmd_env = {
          GEM_HOME = vim.env.RUBY_CONFDIR,
        },
      },
    })

    opts.setup = {
      on_attach = function(client, bufnr)
        require("lazyvim.util").lsp.on_attach(client, bufnr)

        if client.name == "ruby_lsp" or client.name == "solargraph" then
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end
      end,
    }

    return opts
  end,
}
