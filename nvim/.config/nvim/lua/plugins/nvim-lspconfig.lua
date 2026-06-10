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
        -- Run ruby-lsp inside the project's devbox/direnv environment so it
        -- uses the project's Ruby and bundle regardless of how nvim was
        -- launched. cmd runs with cwd set to the resolved root_dir, so the
        -- root's .envrc is what gets evaluated.
        cmd = { "direnv", "exec", ".", "ruby-lsp" },
        reuse_client = function(client, config)
          return client.root_dir == config.root_dir
        end,
      },
    })

    return opts
  end,
}
