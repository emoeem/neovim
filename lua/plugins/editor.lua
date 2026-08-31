return {

  -- nvim-autopairs: 自动括号配对插件
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
    },
  },

  -- Comment.nvim: 注释快捷键插件
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },

  -- nvim-surround: 环绕操作插件
  {
    "kylechui/nvim-surround",
    event = { "BufReadPre", "BufNewFile" },
    version = "*",
    opts = {},
  },

  -- flash.nvim: 快速跳转插件
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
  },
}
