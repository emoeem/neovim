-- =============================================================================
-- keymaps.lua - 基础键位映射（60键优化版）
-- =============================================================================
-- 此文件定义了 Neovim 的所有快捷键映射，采用模块化设计

-- 创建模块对象，用于导出函数供其他文件使用
local M = {}

-- 创建 keymap 函数的简写，减少代码量
local keymap = vim.keymap.set

-- ─────────────────────────────────────────────
-- Leader 键设置
-- ─────────────────────────────────────────────
-- Leader 键是自定义快捷键的前缀键，类似于 Vim 中的 <Leader>
vim.g.mapleader = " "      -- 全局 Leader 键设置为空格键a
vim.g.maplocalleader = " " -- 本地 Leader 键也设置为空格键

-- ─────────────────────────────────────────────
-- 普通模式快捷键
-- ─────────────────────────────────────────────

-- 窗口跳转（Alt + 方向键，与 niri WM 风格一致）
keymap("n", "<A-Left>", "<C-w>h", { noremap = true, silent = true, desc = "跳转左窗口" })
keymap("n", "<A-Down>", "<C-w>j", { noremap = true, silent = true, desc = "跳转下窗口" })
keymap("n", "<A-Up>", "<C-w>k", { noremap = true, silent = true, desc = "跳转上窗口" })
keymap("n", "<A-Right>", "<C-w>l", { noremap = true, silent = true, desc = "跳转右窗口" })

-- 在插入模式下，跳转窗口
-- keymap("i", "<C-h>", "<C-w>h", { noremap = true, silent = true, desc = "跳转左窗口" })
-- keymap("i", "<C-j>", "<C-w>j", { noremap = true, silent = true, desc = "跳转下窗口" })
-- keymap("i", "<C-k>", "<C-w>k", { noremap = true, silent = true, desc = "跳转上窗口" })
-- keymap("i", "<C-l>", "<C-w>l", { noremap = true, silent = true, desc = "跳转右窗口" })


-- 快速退出
keymap("n", "<leader>q", ":q<CR>", { noremap = true, silent = true, desc = "退出" })
keymap("n", "<leader>Q", ":qa<CR>", { noremap = true, silent = true, desc = "全部退出" })
--[[ keymap("n", "<leader>W", ":wa<CR>", { noremap = true, silent = true, desc = "全部保存" }) ]]
keymap("n", "<leader>w", ":w<CR>", { noremap = true, silent = true, desc = "保存" })

-- 窗口操作
keymap("n", "<leader>Wv", "<cmd>vsplit<cr>", { desc = "垂直分割" })
keymap("n", "<leader>Wh", "<cmd>split<cr>", { desc = "水平分割" })
keymap("n", "<leader>Wc", "<cmd>close<cr>", { desc = "关闭窗口" })
keymap("n", "<leader>Wo", "<cmd>only<cr>", { desc = "关闭其他" })
keymap("n", "<leader>Wr", "<cmd>wincmd r<cr>", { desc = "旋转窗口" })
keymap("n", "<leader>Wm", function()
  vim.cmd.wincmd("_")
  vim.cmd.wincmd("|")
end, { desc = "最大化窗口" })
keymap("n", "<leader>W=", "<cmd>wincmd =<cr>", { desc = "平衡窗口" })
-- niri 风格：Alt ± 调宽度，Alt Shift ± 调高度
keymap("n", "<A-->", "<cmd>vertical resize -10<cr>", { desc = "宽度减少" })
keymap("n", "<A-=>", "<cmd>vertical resize +10<cr>", { desc = "宽度增加" })
keymap("n", "<A-S-->", "<cmd>resize -10<cr>", { desc = "高度减少" })
keymap("n", "<A-S-=>", "<cmd>resize +10<cr>", { desc = "高度增加" })

-- 翻页居中
keymap("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true, desc = "向上翻页" })


-- 清除搜索高亮
keymap("n", "<Esc>", ":nohl<Cr>", { noremap = true, silent = true, desc = "清除高亮" })

-- 移动行
keymap("n", "<A-k>", ":m .+1<CR>==", { noremap = true, silent = true, desc = "下移行" })
keymap("n", "<A-i>", ":m .-2<CR>==", { noremap = true, silent = true, desc = "上移行" })

-- 光标移动到最后一行
keymap("n", "gG", "G", { noremap = true, silent = true, desc = "移动到最后一行" })
keymap("v", "gG", "G", { noremap = true, silent = true, desc = "移动到最后一行" })

-- ─────────────────────────────────────────────
-- 插入模式快捷键
-- ─────────────────────────────────────────────
keymap("i", "jj", "<Esc>", { noremap = true, silent = true, desc = "退出插入" })

-- ─────────────────────────────────────────────
-- 可视模式快捷键
-- ─────────────────────────────────────────────
keymap("v", "<A-k>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "下移选中" })
keymap("v", "<A-i>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "上移选中" })
keymap("v", "<", "<gv", { noremap = true, silent = true, desc = "左缩进" })
keymap("v", ">", ">gv", { noremap = true, silent = true, desc = "右缩进" })
keymap("v", "p", '"_dP', { noremap = true, silent = true, desc = "粘贴不覆盖" })

-- ─────────────────────────────────────────────
-- 终端模式快捷键
-- ─────────────────────────────────────────────
keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true, desc = "退出终端" })

-- 插件 & 工具
keymap("n", "<leader>pl", ":Lazy<CR>", { desc = "插件管理" })
keymap("n", "<leader>pm", ":Mason<CR>", { desc = "LSP/工具管理" })

-- ─────────────────────────────────────────────
-- 搜索（由 snacks picker 提供，见 plugins/snacks.lua）
-- ─────────────────────────────────────────────


-- ─────────────────────────────────────────────
-- LSP
-- ─────────────────────────────────────────────
function M.lsp_on_attach(client, bufnr)
  local map = function(keys, func, desc)
    vim.keymap.set("n", keys, func,
      { buffer = bufnr, noremap = true, silent = true, desc = "LSP: " .. desc })
  end
  map("K", vim.lsp.buf.hover, "悬浮文档")
  map("<leader>ca", vim.lsp.buf.code_action, "代码动作")
  -- 重命名交给 inc-rename（增量预览），需要 <leader>rn 返回命令字符串
  vim.keymap.set("n", "<leader>rn", function()
    return ":IncRename " .. vim.fn.expand("<cword>")
  end, { buffer = bufnr, expr = true, desc = "LSP: 重命名（增量预览）" })
  map("[d", vim.diagnostic.goto_prev, "上一诊断")
  map("]d", vim.diagnostic.goto_next, "下一诊断")
end

-- ─────────────────────────────────────────────
-- 自动补全
-- ─────────────────────────────────────────────
function M.cmp_mappings()
  local cmp = require("cmp")
  local luasnip = require("luasnip")

  return cmp.mapping.preset.insert({
    ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-/>"] = cmp.mapping.complete(),
    -- ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  })
end

-- ─────────────────────────────────────────────
-- Git
-- ─────────────────────────────────────────────
function M.gitsigns_on_attach(bufnr)
  local gs = package.loaded.gitsigns
  local map = function(mode, l, r, desc)
    vim.keymap.set(mode, l, r, { buffer = bufnr, desc = "Git: " .. desc })
  end

  map("n", "]h", gs.next_hunk, "下一hunk")
  map("n", "[h", gs.prev_hunk, "上一hunk")
end

-- LazyGit 已迁移到 snacks.lua 的 Snacks.lazygit()

-- ─────────────────────────────────────────────
-- 编辑器工具
-- ─────────────────────────────────────────────
keymap("n", "<leader>e", function() Snacks.explorer() end, { noremap = true, silent = true, desc = "资源管理器" })
keymap({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "Flash跳转" })

-- ─────────────────────────────────────────────
-- Rust 开发
-- ─────────────────────────────────────────────
keymap("n", "<leader>rr", ":RustLsp run<CR>", { desc = "运行" })
keymap("n", "<leader>rt", ":RustLsp testables<CR>", { desc = "测试" })
keymap("n", "<leader>rd", ":RustLsp debuggables<CR>", { desc = "调试" })
keymap("n", "<leader>re", ":RustLsp explainError<CR>", { desc = "解释错误" })
keymap("n", "<leader>rc", ":RustLsp openCargo<CR>", { desc = "Cargo.toml" })
keymap("n", "<leader>rR", ":RustAnalyzer restart<CR>", { desc = "重启Rust-Analyzer" })

--Debug
-- 普通模式 打开诊断
vim.keymap.set("n", "<Leader>dd", "<cmd>lua vim.diagnostic.open_float()<CR>", { desc = "显示当前行诊断", silent = true })
-- 打开全局诊断列表（跨文件）
vim.keymap.set("n", "<Leader>dD", "<cmd>Trouble diagnostics toggle<CR>", { desc = "显示当前工作区诊断", silent = true })

vim.keymap.set('n', 'gD', '<CMD>lua vim.lsp.buf.definition()<CR>', { desc = "跳转到定义" })
vim.keymap.set('n', 'gd', '<CMD>Glance definitions<CR>', { desc = "查看定义" })
vim.keymap.set('n', 'gR', '<CMD>Glance references<CR>', { desc = "查看引用" })
vim.keymap.set('n', 'gY', '<CMD>Glance type_definitions<CR>', { desc = "查看类型定义" })
vim.keymap.set('n', 'gM', '<CMD>Glance implementations<CR>', { desc = "查看实现" })

vim.keymap.set({ "n", "v" }, "<leader>dq", "<cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "代码修复" })


return M
