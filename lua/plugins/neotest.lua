return {
  {
    "nvim-neotest/neotest",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neotest/neotest-python",
      "rouge8/neotest-rust",
      "nvim-neotest/neotest-plenary",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-rust")({
            args = { "--no-fail-fast" },
          }),
          require("neotest-python")({
            runner = "pytest",
          }),
          require("neotest-plenary"),
        },
      })
    end,
    keys = {
      { "<leader>tr", function() require("neotest").run.run() end, desc = "运行最近测试" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "运行当前文件" },
      { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "调试最近测试" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "测试总览" },
      { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "测试输出" },
    },
  },
}
