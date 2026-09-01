return {
  -- 主题备选（主主题 catppuccin-mocha 见 catppuccin.lua）
  -- 原先 themify.nvim 一次性挂了 13 套主题，实际固定用 mocha，
  -- 这里只保留两个备选，需要临时切换时执行：
  --   :colorscheme kanagawa   /   :colorscheme tokyonight
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
  },
}
