return {
  "3rd/image.nvim",
  event = { "BufRead", "BufNewFile" },
  config = function(_, opts)
    require("image").setup(opts)
  end,
  opts = {
    -- kitty 下走 Kitty 图形协议，其它终端（foot/xterm 等）回退 Sixel
    backend = (vim.env.KITTY_WINDOW_ID or (vim.env.TERM or ""):find("kitty", 1, true))
        and "kitty" or "sixel",
    processor = "magick_cli",
    integrations = {
      markdown = {
        enabled = true,
        clear_in_insert_mode = false,
        download_remote_images = false,
        only_render_image_at_cursor = false,
        floating_windows = false,
        filetypes = { "markdown" },
      },
    },
    max_width = 120,
    max_height = 40,
    window_overlap_clear_enabled = true,
    window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "blink-cmp-menu", "blink-cmp-doc", "blink-cmp-signature", "" },
  },
}
