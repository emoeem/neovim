return {

  -- flash.nvim: 快速跳转插件
  -- s + 字符：全屏跳转；S：按语法树节点选择
  -- 注意：flash 没有默认键位，必须在 keys 里显式定义才生效
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash 跳转" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash 语法树选择" },
    },
  },
}

-- 说明：以下三个插件已被更轻的方案替代（2026-09 精简）：
--   Comment.nvim      → Neovim 0.10+ 内置 gcc / gc 注释
--   nvim-autopairs    → mini.pairs（见 plugins/mini.lua）
--   nvim-surround     → mini.surround（gsa/gsd/gsr，见 plugins/mini.lua）
