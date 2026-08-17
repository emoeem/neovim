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
}
