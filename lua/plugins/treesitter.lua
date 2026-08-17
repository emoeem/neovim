return {
  -- nvim-treesitter: Treesitter 语法高亮和代码分析插件
  "nvim-treesitter/nvim-treesitter",

  build = ":TSUpdate",

  opts = {
    ensure_installed = {
      "lua",
      "rust",
      -- 日常语言（dart 已不使用）
      "c",
      "cpp",
      "python",
      "javascript",
      "typescript",
      "tsx",
      "html",
      "css",
      "json",
      "yaml",
      "bash",
      "markdown",
      "markdown_inline",
    },

    highlight = { enable = true },
  },
}
