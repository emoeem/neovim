return {

  -- lualine.nvim: 状态栏插件
  {
    "nvim-lualine/lualine.nvim",
    event = "VimEnter",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "catppuccin/nvim",
    },
    opts = {
      options = {
        component_separators = "|",
        section_separators = "",
        globalstatus = true,

      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },

        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },

  -- bufferline.nvim: 标签栏插件
  {
    "akinsho/bufferline.nvim",
    version = "*",
    event = "BufReadPost",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      local function smart_close(...)
        local bufnr = select(1, ...) or vim.fn.bufnr()
        if vim.bo[bufnr].modified then
          vim.api.nvim_buf_call(bufnr, function()
            vim.cmd.write()
          end)
        end
        local ok = pcall(require("mini.bufremove").delete, bufnr, false)
        if not ok then
          vim.cmd("bdelete! " .. bufnr)
        end
      end

      require("bufferline").setup({
        options = {
          mode = "buffers",
          style_preset = require("bufferline").style_preset.default,
          themable = true,
          numbers = "none",
          close_command = smart_close,
          right_mouse_command = smart_close,
          middle_mouse_command = smart_close,
          indicator = {
            style = "icon",
          },
          buffer_close_icon = "󰅖",
          modified_icon = "●",
          close_icon = "",
          left_trunc_marker = "",
          right_trunc_marker = "",
          max_name_length = 18,
          max_prefix_length = 15,
          truncate_names = true,
          tab_size = 18,
          diagnostics = "nvim_lsp",
          diagnostics_update_in_insert = false,
          offsets = {
            {
              filetype = "snacks_explorer",
              text = "emo & 资源管理器",
              highlight = "Directory",
              text_align = "left",
            },
          },
          color_icons = true,
          show_buffer_icons = true,
          show_buffer_close_icons = true,
          show_close_icon = true,
          show_tab_indicators = true,
          persist_buffer_sort = true,
          separator_style = "thin",
          enforce_regular_tabs = false,
          always_show_bufferline = true,
          hover = {
            enabled = true,
            delay = 200,
            reveal = { "close" },
          },
        },
      })

      vim.keymap.set("n", "<leader>bd", smart_close, { desc = "缓冲区：关闭当前" })
      vim.keymap.set("n", "<leader>bo", ":BufferLineCloseOthers<CR>", { desc = "关闭其他缓冲区" })

    end,
  },

  -- nvim-notify: 通知美化插件
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 3000,
      max_width = 50,
      render = "compact",
      stages = "fade",
      background_colour = "#000000",
    },
    config = function(_, opts)
      local notify = require("notify")
      notify.setup(opts)
      vim.notify = notify
    end,
  },

  -- 一堆美化插件
  {
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
    -- "MeanderingProgrammer/render-markdown.nvim",  -- 已替换为 markview.nvim
  },


  -- noice.nvim: 命令行美化插件
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      cmdline = {
        view = "cmdline_popup",
        format = {
          search_down = { icon = " " },
          search_up = { icon = " " },
        },
      },

      messages = {
        enabled = true,
        view = "notify",
        view_error = "notify",
        view_warn = "notify",
        view_history = "messages",
        view_search = "virtualtext",
      },

      popupmenu = {
        enabled = true,
        backend = "nui",
        kind_icons = true,
      },

      views = {
        cmdline_popup = {
          position = {
            row = 2,
            col = "50%",
          },
          size = {
            width = 60,
            height = "auto",
          },
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
          win_options = {
            winhighlight = {
              Normal = "Normal",
              FloatBorder = "FloatBorder",
            },
          },
        },

        popupmenu = {
          relative = "editor",
          position = {
            row = 8,
            col = "50%",
          },
          size = {
            width = 60,
            height = 10,
          },
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
          win_options = {
            winhighlight = {
              Normal = "Normal",
              FloatBorder = "FloatBorder",
            },
          },
        },

        notify = {
          position = {
            row = 3,
            col = "50%",
          },
          size = {
            width = 50,
            height = "auto",
          },
          border = {
            style = "rounded",
          },
        },
      },

      routes = {
        {
          view = "cmdline_popup",
          filter = { event = "cmdline", kind = "search" },
        },
        {
          view = "cmdline_popup",
          filter = { event = "cmdline", kind = ":" },
        },
        {
          view = "cmdline_popup",
          filter = { event = "cmdline", kind = "/" },
        },
      },

      presets = {
        bottom_search = false,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
        lsp_doc_border = true,
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  }
}
