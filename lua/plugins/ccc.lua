return {
  "uga-rosa/ccc.nvim",
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
