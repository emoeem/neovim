return {
  -- persistence.nvim: 会话管理（按目录保存/恢复窗口与缓冲区）
  -- VeryLazy 保证空参数 nvim 启动时也会加载，退出时才保存会话
  "folke/persistence.nvim",
  event = "VeryLazy",
  opts = {
    options = { "buffers", "win", "tabpages", "curdir" },
  },
  keys = {
    { "<leader>ps", function() require("persistence").load() end, desc = "恢复当前目录会话" },
    { "<leader>pl", function() require("persistence").load({ last = true }) end, desc = "恢复上次会话" },
    { "<leader>pd", function() require("persistence").stop() end, desc = "本会话退出时不保存" },
  },
}
