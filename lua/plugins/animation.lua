-- =============================================================================
-- animation.lua - 动画增强（三类动画各保留一个实现，互不冲突）
-- =============================================================================
-- 冲突规则：同一类动画只保留一个插件，避免叠加卡顿。
--   - 平滑滚动  → neoscroll.nvim（mini.animate.scroll、snacks.scroll 保持关闭）
--   - 光标拖尾  → smear-cursor.nvim（mini.animate.cursor 保持关闭）
--   - 操作反馈  → tiny-glimmer.nvim（yank / 粘贴 / 撤销 / 重做）
-- 三个插件都是 VeryLazy 懒加载，不占启动时间；
  -- 光标拖尾和操作反馈可通过各插件命令临时关闭，
-- 不必删插件。某个类型完全不想要时，注释掉对应 spec 就行。
-- =============================================================================

return {

  -- ── 平滑滚动 ──
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    opts = {
      -- <C-u> 单独处理（见 config），保留原有的"翻半页并居中"习惯
      mappings = { "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
      hide_cursor = true,          -- 滚动时隐藏光标：避免拖影/发虚的关键
      stop_eof = true,             -- 向下滚动到文件末尾即停
      respect_scrolloff = false,
      cursor_scrolls_alone = true,
      easing = "quadratic",
      duration = 200,              -- 200ms，干脆不拖沓；想更柔和可调到 300
      performance_mode = false,
    },
    config = function(_, opts)
      require("neoscroll").setup(opts)
      -- 保留 <C-u>zz 的"翻半页并居中"习惯，同时加上平滑滚动
      vim.keymap.set("n", "<C-u>", function()
        require("neoscroll").scroll(-vim.opt.scroll:get(), {
          duration = 200,
          easing = "quadratic",
        })
        vim.cmd("normal! zz")
      end, { desc = "向上翻页（平滑）" })
    end,
  },

  -- ── 光标移动拖尾 ──
  {
    "sphamba/smear-cursor.nvim",
    event = "VeryLazy",
    opts = {
      -- 关闭命令行模式的光标拖尾：noice 的 cmdline 弹窗会因此每敲一个字就重画，
      -- 和补全候选叠加后看起来卡顿/拖影
      smear_to_cmd = false,
      -- 切换 buffer/窗口时也平滑过渡
      smear_between_buffers = true,
      -- 相邻行内的移动也带拖尾（h/l/j/k 小步移动更顺滑）
      smear_between_neighbor_lines = true,
      -- 滚动时在 buffer 空间绘制，和 neoscroll 配合更一致
      scroll_buffer_space = true,
      -- 插入模式先关掉，避免和输入光标的闪烁叠加产生"拖影感"；想开就改 true
      smear_insert_mode = false,
      -- 让拖尾更"跟手"一点（默认 stiffness/trailing_stiffness 为 0.8/0.6）
      stiffness = 0.7,
      trailing_stiffness = 0.5,
      -- 距离太近不动画，减少不必要的闪烁
      distance_stop_animating = 0.3,
    },
  },

  -- ── 操作反馈动画（yank / 粘贴 / 撤销 / 重做）──
  {
    "rachartier/tiny-glimmer.nvim",
    event = "VeryLazy",
    priority = 10, -- 低优先级，避免覆盖其它插件的键位
    opts = {
      autoreload = true, -- 切换配色（themify）后自动刷新动画颜色
      overwrite = {
        auto_map = true,
        yank = {
          enabled = true,
          default_animation = "fade",
        },
        paste = {
          enabled = true,
          default_animation = "reverse_fade",
        },
        -- 搜索动画默认关闭（n/N 已有 hlsearch 高亮，避免每次跳转都闪一下）；
        -- 想开就把 enabled 改成 true
        search = {
          enabled = false,
          default_animation = "pulse",
        },
        undo = {
          enabled = true,
          default_animation = {
            name = "fade",
            settings = {
              from_color = "DiffDelete",
              max_duration = 450,
              min_duration = 450,
            },
          },
        },
        redo = {
          enabled = true,
          default_animation = {
            name = "fade",
            settings = {
              from_color = "DiffAdd",
              max_duration = 450,
              min_duration = 450,
            },
          },
        },
      },
      animations = {
        -- 默认 400/300ms 略微缩短，反馈更干脆
        fade = {
          max_duration = 350,
          min_duration = 250,
          easing = "outQuad",
        },
        reverse_fade = {
          max_duration = 350,
          min_duration = 250,
          easing = "outBack",
        },
      },
    },
  },
}
