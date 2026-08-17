return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
  keys = {
    { "<leader>dv", "<cmd>DiffviewOpen<CR>", desc = "Git Diff" },
    { "<leader>dh", "<cmd>DiffviewFileHistory<CR>", desc = "文件历史" },
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
