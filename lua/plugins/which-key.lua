return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")
    wk.setup({
      preset = "modern",
      delay = 100,
      expand = 1,
      notify = false,
      plugins = {
        spelling = { enabled = true, suggestions = 20 },
        marks = false,
        registers = false,
        presets = {
          operators = false, motions = false, text_objects = false,
          windows = false, nav = false, z = true, g = true,
        },
      },
      win = { border = "rounded", padding = { 1, 1 }, wo = { winblend = 0 } },
      layout = { width = { max = 60 }, spacing = 3 },
      icons = { breadcrumb = "»", separator = "➜", group = "" },
      position = "center",
      show_help = true,
      show_keys = true,
    })

    wk.add({
      -- ── 文件/编辑 ──
      { "<leader>w", desc = "保存" },
      { "<leader>q", desc = "退出" },
      { "<leader>Q", desc = "全部退出" },
      { "<leader>.", desc = "暂存 buffer" },
      { "<leader>S", desc = "选择暂存" },

      -- ── Buffer 操作 ──
      { "<leader>b", group = "Buffer" },
      { "<leader>bc", desc = "智能关闭" },
      { "<leader>bo", desc = "关闭其他" },
      { "<leader>bl", desc = "关闭左侧" },
      { "<leader>bn", desc = "向右移动" },
      { "<leader>br", desc = "关闭右侧" },
      { "<leader>bh", desc = "向左移动" },

      -- ── 搜索（Picker） ──
      { "<leader>f", group = "搜索" },
      { "<leader><space>", desc = "智能查找" },
      { "<leader>ff", desc = "找文件" },
      { "<leader>fb", desc = "找 buffer" },
      { "<leader>fr", desc = "最近文件" },
      { "<leader>fg", desc = "全局搜索" },
      { "<leader>fG", desc = "全局替换" },
      { "<leader>fw", desc = "搜索词" },
      { "<leader>fc", desc = "当前文件搜索" },
      { "<leader>fs", desc = "文件符号" },
      { "<leader>fS", desc = "工作区符号" },
      { "<leader>fh", desc = "帮助文档" },
      { "<leader>fk", desc = "快捷键" },
      { "<leader>f:", desc = "命令列表" },
      { "<leader>fd", desc = "诊断" },
      { "<leader>f/", desc = "继续搜索" },
      { "<leader>fp", desc = "项目" },
      { "<leader>ft", desc = "TODO 列表" },
      { "<leader>,", desc = "Buffer 列表" },
      { "<leader>/", desc = "全局搜索" },
      { "<leader>:", desc = "命令历史" },

      -- ── Git ──
      { "<leader>g", group = "Git" },
      { "<leader>gg", desc = "LazyGit" },
      { "<leader>gB", desc = "Git 浏览器" },
      { "<leader>dv", desc = "Git Diff" },
      { "<leader>dh", desc = "文件历史" },

      -- ── LSP ──
      { "<leader>l", group = "LSP" },
      { "<leader>lf", desc = "格式化" },
      { "<leader>ca", desc = "代码动作" },
      { "<leader>rn", desc = "重命名" },
      { "<leader>dq", desc = "代码修复" },
      { "<leader>a", desc = "符号大纲" },

      -- ── 诊断/修复 ──
      { "<leader>x", group = "诊断/修复" },
      { "<leader>xx", desc = "全局诊断" },
      { "<leader>xX", desc = "文件诊断" },
      { "<leader>xL", desc = "位置列表" },
      { "<leader>xQ", desc = "快速修复" },
      { "<leader>dd", desc = "行诊断" },
      { "<leader>dD", desc = "工作区诊断" },

      -- ── 调试 ──
      { "<leader>d", group = "调试" },
      { "<leader>dk", desc = "切换断点" },
      { "<leader>dK", desc = "条件断点" },
      { "<leader>dr", desc = "打开 REPL" },
      { "<leader>du", desc = "切换 UI" },

      -- ── 代码操作 ──
      { "<leader>c", group = "代码操作" },
      { "<leader>cd", desc = "构建并调试" },
      { "<leader>cb", desc = "构建" },
      { "<leader>cr", desc = "构建并运行" },
      { "<leader>cR", desc = "重命名文件" },

      -- ── Rust ──
      { "<leader>r", group = "Rust" },
      { "<leader>rr", desc = "运行" },
      { "<leader>rt", desc = "测试" },
      { "<leader>rd", desc = "调试" },
      { "<leader>re", desc = "解释错误" },
      { "<leader>rc", desc = "打开 Cargo.toml" },
      { "<leader>rR", desc = "重启 rust-analyzer" },
      { "<leader>ru", desc = "更新依赖" },
      { "<leader>rU", desc = "升级全部依赖" },
      { "<leader>rs", desc = "查看 crate 详情" },

      -- ── Harpoon ──
      { "<leader>h", group = "Harpoon" },
      { "<leader>hm", desc = "菜单" },
      { "<leader>ha", desc = "标记当前文件" },
      { "<leader>hh", desc = "文件 1" },
      { "<leader>hj", desc = "文件 2" },
      { "<leader>hk", desc = "文件 3" },
      { "<leader>hl", desc = "文件 4" },
      { "<leader>hp", desc = "上一个" },
      { "<leader>hn", desc = "下一个" },
      { "<leader>hL", desc = "清空标记" },

      -- ── 任务 (Overseer) ──
      { "<leader>o", group = "任务" },
      { "<leader>or", desc = "运行任务" },
      { "<leader>ol", desc = "任务列表" },
      { "<leader>oo", desc = "快速操作" },

      -- ── 窗口操作 ──
      { "<leader>W", group = "窗口" },
      { "<leader>Wv", desc = "垂直分割" },
      { "<leader>Wh", desc = "水平分割" },
      { "<leader>Wc", desc = "关闭窗口" },
      { "<leader>Wo", desc = "关闭其他" },
      { "<leader>Wr", desc = "旋转窗口" },
      { "<leader>Wm", desc = "最大化窗口" },
      { "<leader>W=", desc = "平衡窗口" },

      -- ── 插件/工具 ──
      { "<leader>p", group = "插件/工具" },
      { "<leader>pl", desc = "插件管理" },
      { "<leader>pm", desc = "LSP/工具管理" },
      { "<leader>e", desc = "资源管理器" },
      { "<leader>mp", desc = "Markdown 预览" },
      { "<leader>ps", desc = "恢复上次会话" },
      { "<leader>pd", desc = "停止会话保存" },
      { "<leader>n", desc = "通知历史" },
      { "<leader>U", desc = "撤销树" },

      -- ── 测试 ──
      { "<leader>t", group = "测试" },
      { "<leader>tr", desc = "运行最近测试" },
      { "<leader>tf", desc = "运行当前文件" },
      { "<leader>td", desc = "调试最近测试" },
      { "<leader>ts", desc = "测试总览" },
      { "<leader>to", desc = "测试输出" },

      -- ── 切换开关 ──
      { "<leader>u", group = "切换开关" },
      { "<leader>us", desc = "拼写检查" },
      { "<leader>uw", desc = "自动换行" },
      { "<leader>ud", desc = "诊断开关" },
      { "<leader>ug", desc = "缩进线开关" },
      { "<leader>uD", desc = "聚焦模式" },
      { "<leader>uh", desc = "行内提示开关" },

      -- ── 代码折叠（非 leader，按 z 触发） ──
      { "z", group = "代码折叠" },
      { "zM", desc = "关闭所有" },
      { "zR", desc = "展开所有" },
      { "zc", desc = "关闭当前" },
      { "zo", desc = "展开当前" },
      { "za", desc = "切换" },
      { "ze", desc = "向左滚动" },
      { "zs", desc = "向右滚动" },
    })
  end,
}
