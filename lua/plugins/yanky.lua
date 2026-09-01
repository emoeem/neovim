return {
  -- yanky.nvim: 剪切/复制历史 + 智能粘贴
  "gbprod/yanky.nvim",
  event = "VeryLazy",
  opts = {
    -- yank 历史存到 shada，重启后还在
    ring = { storage = "shada" },
    -- 粘贴/复制高亮交给 tiny-glimmer（animation.lua），这里关闭避免双重高亮
    highlight = {
      on_put = false,
      on_yank = false,
    },
    preserve_cursor_position = { enabled = true },
  },
  keys = {
    { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "向后粘贴" },
    { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "向前粘贴" },
    { "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "向后粘贴并保留光标" },
    { "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "向前粘贴并保留光标" },
    { "<c-n>", "<Plug>(YankyCycleForward)", mode = "n", desc = "循环下一个粘贴内容" },
    { "<c-p>", "<Plug>(YankyCycleBackward)", mode = "n", desc = "循环上一个粘贴内容" },
  },
}
