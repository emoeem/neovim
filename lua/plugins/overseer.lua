return {
  -- overseer.nvim：任务运行框架（构建/测试等长任务，输出进 Quickfix）
  -- "运行当前文件"已由 code_runner.nvim 接管（见 plugins/code_runner.lua）
  "stevearc/overseer.nvim",
  cmd = { "OverseerRun", "OverseerToggle", "OverseerQuickAction" },
  keys = {
    { "<leader>or", "<cmd>OverseerRun<CR>", desc = "运行任务" },
    { "<leader>ol", "<cmd>OverseerToggle<CR>", desc = "任务列表" },
    { "<leader>oo", "<cmd>OverseerQuickAction<CR>", desc = "快速操作" },
  },
  opts = {},
}
