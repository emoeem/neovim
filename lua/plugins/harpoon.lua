return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  event = "VeryLazy",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup({})

    local list = harpoon:list()
    local ui = require("harpoon.ui")

    vim.keymap.set("n", "<leader>hh", function() ui:toggle_quick_menu(list) end, { desc = "文件标记：打开列表" })
    vim.keymap.set("n", "<leader>ha", function() list:add() end, { desc = "标记当前文件" })
  end,
}
