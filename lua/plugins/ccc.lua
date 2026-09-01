return {
  -- ccc.nvim: 取色器 + 颜色高亮（CccPick 打开取色面板）
  "uga-rosa/ccc.nvim",
  event = "VeryLazy",
  config = function()
    local ccc = require("ccc")
    ccc.setup({
      -- 开启颜色高亮
      highlighter = {
        auto_enable = true,
        lsp = true,
      },
    })
  end
}
