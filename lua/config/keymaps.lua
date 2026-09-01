local M = {}

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- Everyday editor commands.
map("n", "<leader>w", "<cmd>write<cr>", { desc = "保存" })
map("n", "<leader>q", "<cmd>quit<cr>", { desc = "退出" })
map("n", "<leader>Q", "<cmd>quitall<cr>", { desc = "全部退出" })
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "清除搜索高亮" })
map("i", "jj", "<Esc>", { desc = "退出插入模式" })
map("v", "<", "<gv", { desc = "左缩进并保持选中" })
map("v", ">", ">gv", { desc = "右缩进并保持选中" })
-- 终端输入模式：按一次 Esc 退出输入模式并关闭终端窗口
-- （想保留窗口、只回到普通模式用于滚动/复制时，按 <C-\><C-n>）
map("t", "<Esc>", function()
  vim.cmd("stopinsert")
  pcall(vim.cmd, "close")
end, { desc = "退出并关闭终端" })

-- 任何终端缓冲区（内置终端、Overseer 运行输出等）普通模式下按 q 关闭窗口
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function(args)
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = args.buf, desc = "关闭终端" })
  end,
})

map("n", "<C-i>", "<C-w>k", { desc = "切到上方窗口" })
map("n", "<C-j>", "<C-w>h", { desc = "切到左侧窗口" })
map("n", "<C-k>", "<C-w>j", { desc = "切到下方窗口" })
map("n", "<C-l>", "<C-w>l", { desc = "切到右侧窗口" })

map("n", "<C-PageUp>", "<cmd>vertical resize -5<cr>", { desc = "缩小窗口宽度" })
map("n", "<C-PageDown>", "<cmd>vertical resize +5<cr>", { desc = "扩大窗口宽度" })
map("n", "<C-S-PageUp>", "<cmd>resize -3<cr>", { desc = "缩小窗口高度" })
map("n", "<C-S-PageDown>", "<cmd>resize +3<cr>", { desc = "扩大窗口高度" })

map("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "垂直分割" })
map("n", "<leader>sh", "<cmd>split<cr>", { desc = "水平分割" })
map("n", "<leader>sx", "<cmd>close<cr>", { desc = "关闭窗口" })
map("n", "<leader>so", "<cmd>only<cr>", { desc = "只保留当前窗口" })
map("n", "<leader>se", "<C-w>=", { desc = "均衡窗口" })
map("n", "<leader>sm", function()
  vim.cmd.wincmd("_")
  vim.cmd.wincmd("|")
end, { desc = "最大化窗口" })

map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "插件管理" })
map("n", "<leader>M", "<cmd>Mason<cr>", { desc = "语言服务与工具管理" })
map("n", "<leader>xd", vim.diagnostic.open_float, { desc = "当前诊断" })
map("n", "<leader>e", function()
  Snacks.explorer()
end, { desc = "文件浏览器" })
map("n", "<S-Left>", "<cmd>bprevious<cr>", { desc = "上一个缓冲区" })
map("n", "<S-Right>", "<cmd>bnext<cr>", { desc = "下一个缓冲区" })
map("n", "<S-Up>", "<cmd>tabprevious<cr>", { desc = "上一个标签页" })
map("n", "<S-Down>", "<cmd>tabnext<cr>", { desc = "下一个标签页" })

-- Vim 标签页（tabpage）管理：新建 / 关闭当前 / 只保留当前
map("n", "<leader>Tn", "<cmd>tabnew<cr>", { desc = "标签页：新建" })
map("n", "<leader>Tx", "<cmd>tabclose<cr>", { desc = "标签页：关闭当前" })
map("n", "<leader>To", "<cmd>tabonly<cr>", { desc = "标签页：只保留当前" })

function M.lsp_on_attach(_, bufnr)
  local function lspmap(lhs, rhs, desc)
    map("n", lhs, rhs, { buffer = bufnr, desc = "代码：" .. desc })
  end

  lspmap("K", vim.lsp.buf.hover, "悬浮文档")
  lspmap("gd", vim.lsp.buf.definition, "跳转定义")
  lspmap("gD", function()
    Snacks.picker.lsp_declarations()
  end, "跳转声明（预览）")
  lspmap("gr", vim.lsp.buf.references, "查找引用")
  lspmap("gi", vim.lsp.buf.implementation, "跳转实现")
  lspmap("gy", function()
    Snacks.picker.lsp_type_definitions()
  end, "跳转类型定义（预览）")
  lspmap("<leader>ca", vim.lsp.buf.code_action, "代码动作")
  map("n", "<leader>cr", function()
    return ":IncRename " .. vim.fn.expand("<cword>")
  end, { buffer = bufnr, expr = true, desc = "代码：重命名" })
  lspmap("[d", vim.diagnostic.goto_prev, "上一诊断")
  lspmap("]d", vim.diagnostic.goto_next, "下一诊断")
end

function M.gitsigns_on_attach(bufnr)
  local gs = package.loaded.gitsigns
  map("n", "]h", gs.next_hunk, { buffer = bufnr, desc = "版本控制：下一处修改" })
  map("n", "[h", gs.prev_hunk, { buffer = bufnr, desc = "版本控制：上一处修改" })
end

return M
