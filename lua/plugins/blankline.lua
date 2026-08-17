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
      vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
      vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
      vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
      vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
      vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
      vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
      vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
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
