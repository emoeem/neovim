return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  keys = {
    { "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", desc = "Markdown 浏览器预览" },
  },
  build = ":call mkdp#util#install()",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end,
}
