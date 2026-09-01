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
          -- 颜色高亮统一由 ccc.nvim 渲染，关闭这套避免 dart 文件双重色块
          color = { enabled = false },
        }
      })
    end,
  },
}
