return {
  "stevearc/conform.nvim",
  opts = function(_, opts)
    -- LazyVim configures fish_indent for fish files, but fish isn't installed
    -- and no project here uses it. Drop it so :checkhealth stays clean.
    opts.formatters_by_ft.fish = nil
  end,
}
