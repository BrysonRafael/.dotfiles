return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    opts.diagnostics.underline = false

    opts.inlay_hints.enabled = false

    opts.servers = vim.tbl_deep_extend("force", opts.servers, {
      bashls = {
        filetypes = { "sh", "zsh" },
      },
      ruby_lsp = {
        mason = false,
        reuse_client = function(client, config)
          return client.root_dir == config.root_dir
        end,
      },
    })

    return opts
  end,
}
