return {
  "stevearc/aerial.nvim",
  keys = {
    { "<leader>a", "<cmd>AerialToggle<CR>", desc = "符号大纲" },
  },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    backends = { "lsp", "treesitter", "markdown" },
    layout = {
      default_direction = "right",
      max_width = { 45, 0.25 },
    },
  },
}
