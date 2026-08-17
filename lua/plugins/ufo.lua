return {
  -- nvim-ufo: UFO 代码折叠插件
  "kevinhwang91/nvim-ufo",

  event = "BufReadPost",

  dependencies = { "kevinhwang91/promise-async" },

  config = function()
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99

    require('ufo').setup({
      provider_selector = function(bufnr, filetype, buftype)
        return { "treesitter", "indent" }
      end,
    })

    vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
    vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
  end
}
