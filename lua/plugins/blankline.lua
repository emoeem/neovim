return {
  -- indent-blankline.nvim: 缩进参考线插件
  "lukas-reineke/indent-blankline.nvim",

  event = { "BufReadPost", "BufNewFile" },

  main = "ibl",

  config = function()
    local ibl = require("ibl")

    local highlight = {
      "RainbowRed",
      "RainbowYellow",
      "RainbowBlue",
      "RainbowOrange",
      "RainbowGreen",
      "RainbowViolet",
      "RainbowCyan",
    }

    local hooks = require("ibl.hooks")
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      -- Catppuccin Mocha 色板，与主主题保持一致
      vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#f38ba8" })
      vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#f9e2af" })
      vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#89b4fa" })
      vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#fab387" })
      vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#a6e3a1" })
      vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#cba6f7" })
      vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#94e2d5" })
    end)

    -- 只 setup 一次；启动页/特殊缓冲区交给插件自带的 exclude 处理
    ibl.setup({
      indent = {
        char = "│",
        highlight = highlight,
      },
      -- scope 交给 mini.indentscope（带平滑动画）
      scope = {
        enabled = false,
      },
      exclude = {
        filetypes = {
          "alpha", "dashboard", "startify", "starter",
          "snacks_explorer", "lazy", "mason", "Trouble",
        },
      },
    })
  end,
}
