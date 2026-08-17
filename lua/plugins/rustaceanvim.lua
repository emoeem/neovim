return {
  -- rustaceanvim: Rust 开发增强插件
  "mrcjkb/rustaceanvim",

  ft = { "rust" },

  dependencies = {
    "neovim/nvim-lspconfig",
    "nvim-lua/plenary.nvim",
    "mfussenegger/nvim-dap",
  },

  opts = {
    server = {
      standalone = true,
    },
  },

  config = function(_, opts)
    vim.g.rustaceanvim = opts

    local function set_rust_maps(bufnr)
      local function map(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = "Rust: " .. desc })
      end

      map("<leader>rr", "<cmd>RustLsp run<cr>", "运行")
      map("<leader>rt", "<cmd>RustLsp testables<cr>", "测试")
      map("<leader>rd", "<cmd>RustLsp debuggables<cr>", "调试")
      map("<leader>re", "<cmd>RustLsp explainError<cr>", "解释错误")
      map("<leader>rc", "<cmd>RustLsp openCargo<cr>", "打开 Cargo.toml")
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "rust",
      callback = function(args)
        set_rust_maps(args.buf)
      end,
    })
    if vim.bo.filetype == "rust" then
      set_rust_maps(0)
    end
  end,
}
