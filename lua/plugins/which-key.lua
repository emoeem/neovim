return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")
    wk.setup({
      preset = "modern",
      delay = 150,
      notify = false,
      win = { border = "rounded", padding = { 1, 1 } },
    })

    wk.add({
      { "<leader>b", group = "Buffer" },
      { "<leader>c", group = "代码" },
      { "<leader>d", group = "调试" },
      { "<leader>f", group = "查找" },
      { "<leader>g", group = "Git" },
      { "<leader>h", group = "Harpoon" },
      { "<leader>m", group = "构建" },
      { "<leader>o", group = "任务" },
      { "<leader>r", group = "Rust" },
      { "<leader>s", group = "窗口" },
      { "<leader>t", group = "测试" },
      { "<leader>u", group = "开关" },
      { "<leader>x", group = "诊断" },
    })
  end,
}
