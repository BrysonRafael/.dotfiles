return {
  "zbirenbaum/copilot.lua",
  opts = {
    suggestion = {
      enabled = false,
      auto_trigger = false,
      keymap = {
        accept = false, -- handled by nvim-cmp / blink.cmp
        next = "<M-]>",
        prev = "<M-[>",
      },
    },
  },
}
