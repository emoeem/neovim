return {
  -- code_runner.nvim：多语言"一键运行当前文件"
  -- 自带浮动终端：输出可见、支持 input() 等交互式输入
  -- 可用变量：$file（完整路径）、$fileName、$fileNameWithoutExt、$dir
  "CRAG666/code_runner.nvim",
  cmd = { "RunCode", "RunFile", "RunProject", "RunClose" },
  keys = {
    { "<leader>rf", "<cmd>RunCode<cr>", desc = "运行当前文件" },
    { "<leader>rp", "<cmd>RunProject<cr>", desc = "运行项目（按项目类型识别）" },
  },
  opts = {
    -- float：圆角浮动窗口；运行结束按 Esc 或 q 关闭（全局终端键位接管）
    mode = "float",
    focus = true,
    startinsert = false,
    float = {
      border = "rounded",
      height = 0.6,
      width = 0.7,
    },
    filetype = {
      python = "python3 -u $file",      -- -u 关闭输出缓冲，print 立即显示
      sh = "bash $file",
      bash = "bash $file",
      lua = "lua $file",
      javascript = "node $file",
      typescript = "node $file",
      go = "go run $file",
      rust = "cd $dir && cargo run",
      -- 单文件 C/C++：编译到 /tmp 再运行
      c = "gcc -g $file -o /tmp/$fileNameWithoutExt && /tmp/$fileNameWithoutExt",
      cpp = "g++ -g $file -o /tmp/$fileNameWithoutExt && /tmp/$fileNameWithoutExt",
    },
  },
}
