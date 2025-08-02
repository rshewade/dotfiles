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
    "echasnovski/mini.pick",
    "nvim-telescope/telescope.nvim",
    "hrsh7th/nvim-cmp",    -- Autocompletion for Avante commands/mentions
    "ibhagwan/fzf-lua",    -- For file_selector provider 'fzf'
    -- Optional deps for best UI/UX:
    "stevearc/dressing.nvim",
    "folke/snacks.nvim",
    "zbirenbaum/copilot.lua",
        -- Enhanced Markdown rendering for Avante sidebar/chat:
    {
      "MeanderingProgrammer/render-markdown.nvim",
      -- Recommended: only load for markdown/Avante filetypes
      ft = { "markdown", "Avante" },
      opts = {
        file_types = { "markdown", "Avante" } -- configures filetypes handled
      }
    },
    "nvim-tree/nvim-web-devicons",
  },
}

