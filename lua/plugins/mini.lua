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

    -- 自动括号配对（替代 nvim-autopairs）
    require("mini.pairs").setup()

    -- 环绕操作（替代 nvim-surround）
    -- 前缀用 gs 而不是默认的 s，避免和 flash.nvim 的 s 跳转冲突：
    --   gsa：添加环绕（如 gsaiw" 给单词加引号）
    --   gsd：删除环绕（如 gsd" 删除引号）
    --   gsr：替换环绕（如 gsr"' 把双引号换成单引号）
    --   gsh：高亮环绕
    require("mini.surround").setup({
      mappings = {
        add = "gsa",
        delete = "gsd",
        find = "gsf",
        find_left = "gsF",
        highlight = "gsh",
        replace = "gsr",
        update_n_lines = "gsn",
      },
    })

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
