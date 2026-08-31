return {
  -- mason-tool-installer: 让 Mason 自动安装 conform 需要的格式化工具
  -- （stylua / black / isort / prettier / shfmt / goimports）
  -- gofmt、rustfmt 分别由 Go / Rust 工具链自带，Mason 不提供，无需列入
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- 必须启动时加载：插件的 run_on_start 依赖 VimEnter 事件，
    -- 用 VeryLazy 懒加载会在 VimEnter 之后才载入，导致自动安装从不执行。
    lazy = false,
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "stylua",   -- Lua
        "black",    -- Python
        "isort",    -- Python import 排序
        "prettier", -- JS/TS/JSON/Markdown/HTML/CSS/YAML
        "shfmt",    -- Shell
        -- Go import 整理：需要系统里有 Go 工具链才安装，否则 Mason 会报错
        {
          "goimports",
          condition = function()
            return vim.fn.executable("go") == 1
          end,
        },
      },
      auto_update = false,
      run_on_start = true,
      debounce_hours = 24, -- 24 小时内不重复检查
    },
  },

  -- conform.nvim: 代码格式化插件
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        desc = "格式化当前文件",
      },
    },
    opts = {
      formatters_by_ft = {
        lua         = { "stylua" },
        python      = { "black", "isort" },
        javascript  = { "prettier" },
        typescript  = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        json        = { "prettier" },
        yaml        = { "prettier" },
        markdown    = { "prettier" },
        html        = { "prettier" },
        css         = { "prettier" },
        rust        = { "rustfmt" },
        go          = { "gofmt", "goimports" },
        sh          = { "shfmt" },
      },

      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },
}
