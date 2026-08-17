return {

  -- gitsigns.nvim: Git 状态显示插件
  {
    "lewis6991/gitsigns.nvim",

    event = { "BufReadPre", "BufNewFile" },

    opts = {
      signs = {
        add          = { text = "▎" },
        change       = { text = "▎" },
        delete       = { text = "_" },
        topdelete    = { text = "‾" },
        changedelete = { text = "~" },
        untracked    = { text = "▎" },
      },

      on_attach = function(bufnr)
        require("config.keymaps").gitsigns_on_attach(bufnr)
      end,
    },
  },
}
