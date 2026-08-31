return {
  -- nvim-dap: 调试适配器协议插件
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
      },
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },
      {
        "Weissle/persistent-breakpoints.nvim",
        opts = {},
      },

      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = { "williamboman/mason.nvim" },
        opts = {
          automatic_installation = true,
          handlers = {},
          -- 这里的名称是 DAP 适配器名，不是 Mason 包名：
          -- codelldb → C/C++/Rust 调试；python → Mason 自动安装 debugpy。
          -- debugpy 装好后会自动注册 dap.adapters.python 与
          -- dap.configurations.python（"Python: Launch file"），无需手写。
          ensure_installed = { "codelldb", "python" },
        },
      },
    },

    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      local pb = require("persistent-breakpoints")

      dapui.setup()
      pb.setup({ load_breakpoints_event = { "BufReadPost" } })

      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = vim.fn.stdpath("data")
              .. "/mason/bin/codelldb",
          args = { "--port", "${port}" },
        },
      }

      --- Find the first ELF executable in a directory
      local function find_executable(dir)
        if vim.fn.isdirectory(dir) == 0 then
          return nil
        end
        local handle = vim.uv.fs_scandir(dir)
        if not handle then
          return nil
        end
        while true do
          local name = vim.uv.fs_scandir_next(handle)
          if not name then
            break
          end
          local full = dir .. "/" .. name
          local stat = vim.uv.fs_stat(full)
          if stat and stat.type == "file" and vim.fn.executable(full) == 1 then
            -- crude ELF check: read first 4 bytes
            local fd = vim.uv.fs_open(full, "r", 438)
            if fd then
              local buf = vim.uv.fs_read(fd, 4, 0)
              vim.uv.fs_close(fd)
              if buf and buf:sub(1, 4) == "\127ELF" then
                return full
              end
            end
          end
        end
        return nil
      end

      local function build_cmds(cwd, build_dir)
        local cmds = {}
        if vim.fn.filereadable(cwd .. "/CMakeLists.txt") == 1 then
          table.insert(cmds, "cmake -S " .. vim.fn.shellescape(cwd) .. " -B " .. vim.fn.shellescape(build_dir) .. " -DCMAKE_BUILD_TYPE=Debug")
        end
        table.insert(cmds, "cmake --build " .. vim.fn.shellescape(build_dir))
        return cmds
      end

      --- Run build in ./build directory, then call on_success callback
      local function run_build(on_success)
        local cwd = vim.fn.getcwd()
        local build_dir = cwd .. "/build"
        local has_cmake = vim.fn.filereadable(cwd .. "/CMakeLists.txt") == 1
            or vim.fn.filereadable(build_dir .. "/CMakeCache.txt") == 1
        if not has_cmake then
          vim.notify(
            "未检测到 CMake 项目（没有 CMakeLists.txt 或 build/CMakeCache.txt）。\n"
              .. "单个 C/C++ 文件请用 <leader>rf 编译并运行。",
            vim.log.levels.WARN
          )
          return
        end
        if vim.fn.isdirectory(build_dir) == 0 then
          vim.fn.mkdir(build_dir, "p")
        end
        local cmds = build_cmds(cwd, build_dir)
        local cmd = table.concat(cmds, " && ")
        local stderr_data = {}
        vim.notify("Building C++ project...", vim.log.levels.INFO)
        vim.fn.jobstart({ "sh", "-c", cmd }, {
          on_stderr_nr = function(_, data)
            if data then
              table.insert(stderr_data, data)
            end
          end,
          on_exit = function(_, code)
            if code == 0 then
              vim.notify("Build succeeded", vim.log.levels.INFO)
              if on_success then
                vim.schedule(on_success)
              end
            else
              local msg = "Build failed"
              if #stderr_data > 0 then
                msg = msg .. "\n" .. table.concat(stderr_data, "\n")
              end
              vim.notify(msg, vim.log.levels.ERROR)
            end
          end,
        })
      end

      dap.configurations.cpp = {
        {
          name = "Launch",
          type = "codelldb",
          request = "launch",
          program = function()
            local build_dir = vim.fn.getcwd() .. "/build"
            local exe = find_executable(build_dir)
            if exe then
              return exe
            end
            return vim.fn.input("Binary: ", build_dir .. "/", "file")
          end,
          cwd = vim.fn.getcwd(),
          stopOnEntry = true,
        },
      }
      dap.configurations.c = dap.configurations.cpp

      vim.keymap.set("n", "<leader>md", function()
        run_build(function() dap.continue() end)
      end, { desc = "构建：C++ 构建并调试" })

      vim.keymap.set("n", "<leader>mb", function()
        run_build()
      end, { desc = "构建：C++ 构建项目" })

      vim.keymap.set("n", "<leader>mr", function()
        run_build(function()
          local build_dir = vim.fn.getcwd() .. "/build"
          local exe = find_executable(build_dir)
          if exe then
            vim.cmd("terminal " .. vim.fn.shellescape(exe))
          else
            vim.notify("No executable found in build/", vim.log.levels.ERROR)
          end
        end)
      end, { desc = "构建：C++ 构建并运行" })

      dap.configurations.rust = {
        {
          name = "Launch",
          type = "codelldb",
          request = "launch",

          program = function()
            return vim.fn.input(
              "Binary: ",
              vim.fn.getcwd() .. "/target/debug/",
              "file"
            )
          end,

          cwd = vim.fn.getcwd(),
          stopOnEntry = false,
        },
      }

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "调试：启动/继续" })
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "调试：切换断点" })
      vim.keymap.set("n", "<leader>dB", function() dap.set_breakpoint(vim.fn.input("断点条件：")) end, { desc = "调试：条件断点" })
      vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "调试：单步跳过" })
      vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "调试：单步进入" })
      vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "调试：单步退出" })
      vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "调试：打开交互终端" })
      vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "调试：切换界面" })
    end,
  },
}
