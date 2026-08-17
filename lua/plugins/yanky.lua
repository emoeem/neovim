return {
  -- yanky.nvim: 剪切/复制历史 + 智能粘贴
  "gbprod/yanky.nvim",
  event = "VeryLazy",
  opts = {
    -- yank 历史存到 shada，重启后还在
    ring = { storage = "shada" },
    -- 粘贴/复制后高亮反馈（时长 300ms）
    highlight = {
      on_put = true,
      on_yank = true,
      timer = 300,
    },
    preserve_cursor_position = { enabled = true },
  },
  keys = {
    { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "粘贴（yanky）" },
    { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "向前粘贴（yanky）" },
    { "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "粘贴并保留光标" },
    { "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "向前粘贴并保留光标" },
    { "<c-n>", "<Plug>(YankyCycleForward)", desc = "循环下一个粘贴内容" },
    { "<c-p>", "<Plug>(YankyCycleBackward)", desc = "循环上一个粘贴内容" },
    { "<leader>py", function() require("yanky.sources.snacks").pick() end, desc = "Yank 历史" },
  },
}
