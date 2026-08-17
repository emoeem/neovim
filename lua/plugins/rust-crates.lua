return {
  -- crates.nvim: Rust Crates 插件
  'saecki/crates.nvim',

  tag = 'stable',

  ft = { 'rust', 'toml' },

  config = function()
    require('crates').setup({
      autoload = true,
    })
  end,

  keys = {
    { '<leader>ru', '<cmd>CratesUpdate<CR>', desc = '更新依赖' },
    { '<leader>rU', '<cmd>CratesUpgrade<CR>', desc = '升级全部依赖' },
    { '<leader>rs', '<cmd>CratesShow<CR>', desc = '查看 crate 详情' },
  },
}
