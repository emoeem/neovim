return {
  -- lazydev.nvim: 编辑 Neovim 配置时，让 lua_ls 认识 vim.* 与插件库
  -- 补全源通过 blink.cmp 的 providers.lazydev 接入（见 completion.lua）
  "folke/lazydev.nvim",
  ft = "lua",
  opts = {
    library = {
      -- vim.uv 的类型定义
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      -- 配置里直接用 Snacks 全局变量，加载 snacks 的类型
      { path = "snacks.nvim", words = { "Snacks" } },
    },
  },
}
