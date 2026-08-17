return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = {
    options = { "buffers", "win", "tabpages", "curdir" },
  },
  keys = {
    { "<leader>ps", function() require("persistence").load({ last = true }) end, desc = "恢复上次会话" },
    { "<leader>pd", function() require("persistence").stop() end, desc = "停止会话保存" },
  },
}
