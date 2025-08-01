return {
  "yetone/avante.nvim",
  build = "make", -- required for native dependencies
  event = "VeryLazy",
  opts = {
    provider = "copilot", -- or "openai", "claude", etc.
    -- add your provider/key details in opts as needed
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    -- Optional deps for best UI/UX:
    "stevearc/dressing.nvim",
    "zbirenbaum/copilot.lua",
    "MeanderingProgrammer/render-markdown.nvim",
    "nvim-tree/nvim-web-devicons",
  },
}

