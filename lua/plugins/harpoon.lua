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

    vim.keymap.set("n", "<leader>hm", function() ui:toggle_quick_menu(list) end, { desc = "Harpoon 菜单" })
    vim.keymap.set("n", "<leader>ha", function() list:add() end, { desc = "标记当前文件" })
    vim.keymap.set("n", "<leader>hh", function() list:select(1) end, { desc = "文件 1" })
    vim.keymap.set("n", "<leader>hj", function() list:select(2) end, { desc = "文件 2" })
    vim.keymap.set("n", "<leader>hk", function() list:select(3) end, { desc = "文件 3" })
    vim.keymap.set("n", "<leader>hl", function() list:select(4) end, { desc = "文件 4" })
    vim.keymap.set("n", "<leader>hp", function() list:prev() end, { desc = "上一个" })
    vim.keymap.set("n", "<leader>hn", function() list:next() end, { desc = "下一个" })
    vim.keymap.set("n", "<leader>hL", function() list:clear() end, { desc = "清空标记" })
  end,
}
