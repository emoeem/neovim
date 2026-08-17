return {
  "folke/todo-comments.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    signs = true,
  },
  keys = {
    { "<leader>ft", "<cmd>TodoTrouble<CR>", desc = "TODO 列表" },
  },
}
