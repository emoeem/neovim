return {
  {
    "akinsho/flutter-tools.nvim",
    ft = { "dart" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- 可选，提供更好的 UI 弹窗
    },
    config = function()
      require("flutter-tools").setup({
        lsp = {
          color_render = true,
        }
      })
    end,
  },
}
