return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "版本控制：查看差异" },
    { "<leader>gh", "<cmd>DiffviewFileHistory<CR>", desc = "版本控制：文件历史" },
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
