return {

  -- flash.nvim: 快速跳转插件
  -- s + 字符：全屏跳转；S：按语法树节点选择
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
  },
}

-- 说明：以下三个插件已被更轻的方案替代（2026-09 精简）：
--   Comment.nvim      → Neovim 0.10+ 内置 gcc / gc 注释
--   nvim-autopairs    → mini.pairs（见 plugins/mini.lua）
--   nvim-surround     → mini.surround（gsa/gsd/gsr，见 plugins/mini.lua）
