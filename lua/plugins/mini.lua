return {
  "echasnovski/mini.nvim",
  event = "VeryLazy",
  config = function()
    -- 平滑动画：光标/滚动动画会导致上下移动拖影卡顿，全部关闭；
    -- 动画由 plugins/animation.lua 接管：neoscroll（滚动）/ smear-cursor（光标）/ tiny-glimmer（操作反馈）
    -- 这里保持关闭，避免和上面三者的同类动画叠加卡顿
    -- 想恢复某一项时把对应的 enable 改回 true 即可
    require("mini.animate").setup({
      cursor = { enable = false },
      scroll = { enable = false },
      resize = { enable = false },
      open = { enable = false },
      close = { enable = false },
    })

    -- 智能删除 buffer（替代 bufferline 里手写的 smart_close）
    require("mini.bufremove").setup()

    -- 缩进范围高亮（替代 indent-blankline 的 scope）
    require("mini.indentscope").setup({
      draw = {
        animation = require("mini.indentscope").gen_animation.quadratic({
          easing = "out",
          duration = 300,
          unit = "total",
        }),
      },
    })
  end,
}
