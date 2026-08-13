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
        --
        -- BUNDLE_APP_CONFIG points bundler at an isolated, project-agnostic
        -- config dir instead of the repo's .bundle/config. Some projects
        -- (e.g. via `bundle install --frozen` in their setup scripts) pin
        -- frozen: true there, which blocks ruby-lsp from writing the
        -- lockfile for its composed bundle on startup and crashes it before
        -- it ever attaches. BUNDLE_FROZEN=false only takes effect once the
        -- repo's local config is out of the picture, since local config
        -- otherwise wins over env vars.
        cmd = {
          "direnv",
          "exec",
          ".",
          "env",
          "BUNDLE_FROZEN=false",
          "BUNDLE_APP_CONFIG=" .. vim.fn.stdpath("cache") .. "/ruby-lsp-bundle",
          "ruby-lsp",
        },
        reuse_client = function(client, config)
          return client.root_dir == config.root_dir
        end,
      },
    })

    return opts
  end,
}
