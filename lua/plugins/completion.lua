local kind_icons = {
  Text          = "",
  Method        = "",
  Function      = "",
  Constructor   = "",
  Field         = "",
  Variable      = "",
  Class         = "",
  Interface     = "",
  Module        = "",
  Property      = "",
  Unit          = "",
  Value         = "",
  Enum          = "",
  Keyword       = "",
  Snippet       = "",
  Color         = "",
  File          = "",
  Reference     = "",
  Folder        = "",
  EnumMember    = "",
  Constant      = "",
  Struct        = "",
  Event         = "",
  Operator      = "",
  TypeParameter = "",
}

return {

  -- LuaSnip: Lua 代码片段引擎
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()

      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node
      local rep = require("luasnip.extras").rep

      -- 1. 保留你之前的 C++ 模版
      ls.add_snippets("cpp", {
        s("myclass", {
          t("class "), i(1, "ClassName"), t({ " {", "public:", "    " }),
          rep(1), t("();"),
          t({ "", "    ~" }), rep(1), t("();"),
          t({ "", "};" }),
        }),
      })

      -- 2. 新增 Dart 模版
      -- 在 .dart 文件中敲 `myclass` 触发
      ls.add_snippets("dart", {
        s("myclass", {
          t("class "), i(1, "ClassName"), t({ " {", "  " }),
          -- 构造函数
          rep(1), t("();"),
          -- 模拟析构/资源释放的 dispose 方法
          t({ "", "", "  void dispose() {", "    // TODO: implement dispose", "  }", "}" }),
        }),
      })
    end,
  },

  -- blink.cmp: 更快、更现代的自动补全插件（替代 nvim-cmp）
  -- 保留与 nvim-cmp 一致的操作习惯：C-j/C-k 选择、C-b/C-f 滚动文档、C-/ 手动触发、CR 确认
  {
    "saghen/blink.cmp",
    version = "1.*",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = { "L3MON4D3/LuaSnip" },
    opts = {
      -- 使用 LuaSnip 作为片段引擎（原有 myclass 模版等继续生效）
      snippets = { preset = "luasnip" },

      keymap = {
        preset = "default",
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" }, -- 覆盖默认的 show_signature，保持你的选择习惯
        ["<C-/>"] = { "show", "show_documentation", "hide_documentation" },
        ["<CR>"] = { "accept", "fallback" },
      },

      sources = {
        -- 与之前 nvim-cmp 相同的优先级：LSP > 片段 > buffer > 路径
        default = { "lsp", "snippets", "buffer", "path" },
        providers = {
          lsp      = { module = "blink.cmp.sources.lsp",      name = "LSP",  score_offset = 100 },
          snippets = { module = "blink.cmp.sources.snippets", name = "Snip", score_offset = 80 },
          buffer   = { module = "blink.cmp.sources.buffer",   name = "Buf",  score_offset = 0 },
          path     = { module = "blink.cmp.sources.path",     name = "Path", score_offset = -25 },
        },
      },

      -- 命令模式补全（blink v1.10 起 `sources.cmdline` 已迁移到 `cmdline.sources`）
      cmdline = {
        enabled = true,
        keymap = { preset = "cmdline" },
        sources = { "cmdline", "path", "buffer" },
      },

      completion = {
        documentation = {
          auto_show = true,
          window = { border = "rounded" },
        },
        ghost_text = { enabled = true },
        list = {
          selection = { preselect = true, auto_insert = false },
        },
        menu = { border = "rounded" },
      },

      -- 函数签名提示（C-k 不再用于开关，改为自动显示）
      signature = { enabled = true },

      appearance = {
        nerd_font_variant = "mono",
        kind_icons = kind_icons,
      },
    },
  },
}
