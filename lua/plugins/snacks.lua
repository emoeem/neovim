return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- 启动页
    dashboard = {
      enabled = true,
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup", padding = 1 },
      },
    },

    -- 搜索器（取代 Telescope）
    picker = { enabled = true },

    -- 文件管理器（取代 nvim-tree）
    explorer = { enabled = true },

    -- LazyGit 集成
    lazygit = { enabled = true },

    -- 行号列美化
    statuscolumn = { enabled = true },

    -- Git 浏览器
    gitbrowse = { enabled = true },

    -- 输入框美化
    input = { enabled = true },

    -- 图片预览
    image = { enabled = true },

    -- 大文件优化
    bigfile = { enabled = true },

    -- 平滑滚动（与 mini.animate 叠加会造成卡顿，已关闭；
    -- 滚动动画已由 plugins/animation.lua 的 neoscroll 接管）
    scroll = { enabled = false },

    -- 代码作用域
    scope = { enabled = true },

    -- 快速打开文件
    quickfile = { enabled = true },

    -- LSP 引用导航
    words = { enabled = true },

    -- 暂存 buffer
    scratch = { enabled = true },

    -- 文件重命名
    rename = { enabled = true },
  },
  keys = {
    -- ── 顶部 Pickers ──
    { "<leader><space>", function() Snacks.picker.smart() end, desc = "智能查找文件" },
    { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffer 列表" },
    { "<leader>/", function() Snacks.picker.grep() end, desc = "全局搜索" },
    { "<leader>:", function() Snacks.picker.command_history() end, desc = "命令历史" },

    -- ── 文件查找 ──
    { "<leader>ff", function() Snacks.picker.files() end, desc = "找文件" },
    { "<leader>fb", function() Snacks.picker.buffers() end, desc = "找 buffer" },
    { "<leader>fr", function() Snacks.picker.recent() end, desc = "最近文件" },
    { "<leader>fp", function() Snacks.picker.projects() end, desc = "项目" },

    -- ── 内容搜索 ──
    { "<leader>fg", function() Snacks.picker.grep() end, desc = "全局搜索" },
    { "<leader>fw", function() Snacks.picker.grep_word() end, desc = "搜索词", mode = { "n", "x" } },
    { "<leader>fc", function() Snacks.picker.lines() end, desc = "当前文件搜索" },

    -- ── 符号查找 ──
    { "<leader>fs", function() Snacks.picker.lsp_symbols() end, desc = "文件符号" },
    { "<leader>fS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "工作区符号" },

    -- ── 其他搜索 ──
    { "<leader>fh", function() Snacks.picker.help() end, desc = "帮助文档" },
    { "<leader>fk", function() Snacks.picker.keymaps() end, desc = "快捷键" },
    { "<leader>f:", function() Snacks.picker.commands() end, desc = "命令" },
    { "<leader>fd", function() Snacks.picker.diagnostics() end, desc = "诊断" },
    { "<leader>f/", function() Snacks.picker.resume() end, desc = "继续搜索" },

    -- ── 通知 ──
    { "<leader>n", function() Snacks.notifier.show_history() end, desc = "通知历史" },

    -- ── Git ──
    { "<leader>gg", function() Snacks.lazygit() end, desc = "LazyGit" },
    { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git 浏览器", mode = { "n", "v" } },

    -- ── 暂存 buffer ──
    { "<leader>.", function() Snacks.scratch() end, desc = "暂存 buffer" },
    { "<leader>S", function() Snacks.scratch.select() end, desc = "选择暂存 buffer" },

    -- ── 文件重命名 ──
    { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "重命名文件" },

    -- ── 切换开关 ──
    { "<leader>us", function() Snacks.toggle.option("spell", { name = "拼写检查" }):map("<leader>us") end, desc = "拼写检查" },
    { "<leader>uw", function() Snacks.toggle.option("wrap", { name = "自动换行" }):map("<leader>uw") end, desc = "自动换行" },
    { "<leader>ud", function() Snacks.toggle.diagnostics():map("<leader>ud") end, desc = "诊断开关" },
    { "<leader>ug", function() Snacks.toggle.indent():map("<leader>ug") end, desc = "缩进线开关" },
    { "<leader>uD", function() Snacks.toggle.dim():map("<leader>uD") end, desc = "聚焦模式" },
    { "<leader>uh", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
    end, desc = "行内提示开关" },
  },
}
