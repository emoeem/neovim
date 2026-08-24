return {

  -- mason.nvim: LSP 服务器安装管理器
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
      ui = {
        border = "rounded",
        icons = {
          package_installed   = "✓",
          package_pending     = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },

  -- mason-lspconfig.nvim: Mason 和 lspconfig 的桥梁
  {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      local keymaps = require("config.keymaps")
      local on_attach = keymaps.lsp_on_attach

      -- 统一为所有由 lspconfig 管理的 server 提供补全能力与 LSP 快捷键
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local has_blink, blink = pcall(require, "blink.cmp")
      if has_blink and blink.get_lsp_capabilities then
        capabilities = blink.get_lsp_capabilities(capabilities)
      end

      vim.lsp.config("*", {
        on_attach = on_attach,
        capabilities = capabilities,
      })

      vim.diagnostic.config({
        virtual_text = {
          prefix = "●",
        },
        signs = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = "rounded",
          source = "always",
        },
      })

      local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      -- 内置 inlay hints：服务端支持时自动启用（替代已废弃的 inlay-hints.nvim）
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client:supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
          end
        end,
      })

      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "pyright",
          "clangd",
          "ts_ls",
          "bashls",
          "html",
          "cssls",
          "jsonls",
          "yamlls",
        },
        -- mason-lspconfig v2：自动启用 mason 里已安装的 server，
        -- rust_analyzer / dartls 分别由 rustaceanvim、flutter-tools 管理，排除掉避免重复启动
        automatic_enable = {
          exclude = { "rust_analyzer", "dartls" },
        },
      })
    end,
  },
}
