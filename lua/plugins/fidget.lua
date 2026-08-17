return {
  -- fidget.nvim: LSP 进度提示（rust-analyzer 加载、格式化、build 等）
  "j-hui/fidget.nvim",
  event = "LspAttach",
  opts = {
    notification = {
      window = {
        winblend = 0,
        border = "rounded",
      },
    },
    progress = {
      display = {
        progress_icon = { pattern = "dots" },
      },
    },
  },
}
