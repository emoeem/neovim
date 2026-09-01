return {
  "stevearc/oil.nvim",
  -- 必须启动时加载：default_file_explorer 要求 oil 在启动时就绪，
  -- 否则 `nvim 某个目录/` 打开目录时不会被 oil 接管
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "-", "<cmd>Oil<CR>", desc = "文件系统浏览器" },
  },
  opts = {
    default_file_explorer = true,
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    view_options = {
      show_hidden = true,
    },
  },
}
