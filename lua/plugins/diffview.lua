return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Git: Diff" },
    { "<leader>gh", "<cmd>DiffviewFileHistory<CR>", desc = "Git: 文件历史" },
  },
  config = function()
    require("diffview").setup({
      enhanced_diff_hl = true,
      file_panel = {
        width = 35,
        win_config = { position = "left" },
      },
    })
  end,
}
