return {
  "stevearc/overseer.nvim",
  cmd = { "OverseerRun", "OverseerToggle", "OverseerQuickAction" },
  keys = {
    { "<leader>or", "<cmd>OverseerRun<CR>", desc = "运行任务" },
    { "<leader>ol", "<cmd>OverseerToggle<CR>", desc = "任务列表" },
    { "<leader>oo", "<cmd>OverseerQuickAction<CR>", desc = "快速操作" },
    -- 多语言"运行当前文件"：Python / C / C++ / Shell / Lua / JS/TS / Go / Rust
    { "<leader>rf", function()
      require("overseer").run_task({ name = "运行当前文件" })
    end, desc = "运行当前文件" },
  },
  config = function(_, opts)
    require("overseer").setup(opts)

    local overseer = require("overseer")

    -- 直接解释执行的脚本语言：解释器 + 当前文件
    local script_runners = {
      python           = { "python3" },
      sh               = { "bash" },
      bash             = { "bash" },
      lua              = { "lua" },
      javascript       = { "node" },
      javascriptreact  = { "node" },
      typescript       = { "node" },
      typescriptreact  = { "node" },
      go               = { "go", "run" },
    }

    overseer.register_template({
      name = "运行当前文件",
      tags = { overseer.TAG.RUN },
      priority = 60,
      builder = function(_params)
        local file = vim.fn.expand("%:p")
        local ft = vim.bo.filetype
        local dir = vim.fn.fnamemodify(file, ":h")
        local base = vim.fn.fnamemodify(file, ":t")

        local cmd
        if ft == "rust" then
          -- Rust 交给 cargo，在当前文件所在目录向上找 Cargo.toml
          cmd = { "cargo", "run" }
        elseif ft == "c" or ft == "cpp" then
          -- 单文件 C/C++：先编译到 /tmp，再运行（适合没有 CMake 的快速脚本）
          local cc = ft == "c" and "gcc" or "g++"
          local bin = "/tmp/nvim-run-" .. vim.fn.getpid() .. "-" .. vim.fn.fnamemodify(base, ":t:r")
          local shell = vim.fn.shellescape(cc)
              .. " -g " .. vim.fn.shellescape(file)
              .. " -o " .. vim.fn.shellescape(bin)
              .. " && " .. vim.fn.shellescape(bin)
          cmd = { "sh", "-c", shell }
        elseif script_runners[ft] then
          cmd = vim.list_extend(vim.deepcopy(script_runners[ft]), { file })
        else
          vim.notify("暂不支持运行 " .. (ft == "" and "未知" or ft) .. " 文件", vim.log.levels.WARN)
          return nil
        end

        return {
          name = "运行: " .. base,
          cmd = cmd,
          cwd = dir,
          components = {
            "default",
            { "on_output_quickfix", open = false },
          },
        }
      end,
    })
  end,
}
