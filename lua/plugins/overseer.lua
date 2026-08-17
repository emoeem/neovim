return {
  "stevearc/overseer.nvim",
  cmd = { "OverseerRun", "OverseerToggle", "OverseerQuickAction" },
  keys = {
    { "<leader>or", "<cmd>OverseerRun<CR>", desc = "运行任务" },
    { "<leader>ol", "<cmd>OverseerToggle<CR>", desc = "任务列表" },
    { "<leader>oo", "<cmd>OverseerQuickAction<CR>", desc = "快速操作" },
  },
  opts = {},
}
