# Neovim 配置详解

> 基于 lazy.nvim 的模块化配置，适用于 Neovim >= 0.11（当前环境 0.12.x）。
> 配置根目录：`~/.config/nvim`

## 目录结构

```
~/.config/nvim/
├── init.lua                  # 入口：加载 options → keymaps → lazy
├── lazy-lock.json            # 插件版本锁
├── README.md                 # 安装说明
├── NVIM_CONFIG.md            # 本文档
└── lua/
    ├── config/
    │   ├── options.lua       # 编辑器基础选项
    │   ├── keymaps.lua       # 全局键位 + LSP/cmp/gitsigns 共享函数
    │   └── lazy.lua          # lazy.nvim 初始化与全局配置
    └── plugins/              # 每个插件一个文件，由 lazy 自动导入
```

启动流程：`init.lua` 先加载编辑器选项，再注册全局键位，最后交给 lazy.nvim
按需懒加载所有插件。

## 编辑器基础设置（options.lua）

| 设置 | 值 | 说明 |
| --- | --- | --- |
| 行号 | `number` + `relativenumber` | 当前行绝对行号，其余相对行号 |
| 缩进 | tabstop/shiftwidth = 2，expandtab | 2 空格缩进 |
| 搜索 | smartcase + hlsearch + incsearch | 智能大小写、实时预览、高亮 |
| 界面 | cursorline、signcolumn、scrolloff=8 | 当前行高亮、符号列、滚动留白 |
| 窗口 | splitright / splitbelow | 新窗口右/下打开 |
| 文件 | undofile、无 swap/backup | 持久化撤销 |
| 剪贴板 | clipboard=unnamedplus | 与系统剪贴板互通 |
| 性能 | updatetime=250、timeoutlen=300 | 快速响应 CursorHold 与快捷键 |
| 补全 | pumheight=10、completeopt=menuone,noselect | 补全菜单行为 |

## 插件清单

### 核心 / 管理

| 插件 | 作用 | 加载方式 |
| --- | --- | --- |
| folke/lazy.nvim | 插件管理器，自动导入 `lua/plugins/` | 启动 |

### 主题与界面

| 插件 | 作用 | 加载方式 |
| --- | --- | --- |
| catppuccin/nvim | 默认主题（mocha，透明背景），集成 cmp/snacks/notify/mini 等 | priority 1000 |
| LmanTW/themify.nvim | 主题管理器，内置 16 套主题可随时切换 | 启动 |
| nvim-lualine/lualine.nvim | 状态栏（模式、分支、诊断、文件名） | VimEnter |
| akinsho/bufferline.nvim | 顶部 buffer 标签页，支持智能关闭、拖拽 | BufReadPost |
| rcarriga/nvim-notify | 通知美化 | 启动 |
| folke/noice.nvim | 命令行弹窗、补全菜单美化 | VeryLazy |
| stevearc/dressing.nvim | 统一 vim.ui 输入/选择弹窗 | 启动 |
| nvim-tree/nvim-web-devicons | 文件类型图标 | 依赖 |
| MunifTanjim/nui.nvim | UI 组件库 | 依赖 |
| folke/snacks.nvim | 全家桶：启动页、搜索器、文件管理器、lazygit、状态列、图片预览、大文件优化等 | 启动 |

### 编辑增强

| 插件 | 作用 | 加载方式 |
| --- | --- | --- |
| nvim-treesitter/nvim-treesitter | 语法高亮与解析器管理 | 启动 |
| nvim-treesitter/nvim-treesitter-textobjects | 基于语法树的选择/移动文本对象 | VeryLazy |
| nvim-treesitter/nvim-treesitter-context | 滚动时固定显示当前函数/类上下文 | VeryLazy |
| kevinhwang91/nvim-ufo | 高性能代码折叠（zR/zM） | BufReadPost |
| HiPhish/rainbow-delimiters.nvim | 彩虹括号 | BufReadPre |
| lukas-reineke/indent-blankline.nvim | 缩进参考线（scope 交给 mini.indentscope） | BufReadPost |
| windwp/nvim-ts-autotag | HTML/JSX 标签自动闭合与重命名 | InsertEnter |
| numToStr/Comment.nvim | `gcc`/`gc` 注释 | BufReadPre |
| RRethy/vim-illuminate | 高亮光标所在词的其他出现位置 | BufReadPre |
| kylechui/nvim-surround | `ys`/`cs`/`ds` 环绕操作 | BufReadPre |
| akinsho/toggleterm.nvim | 浮动终端（`<C-\>`） | 按键 |
| folke/flash.nvim | 快速跳转（`s`） | VeryLazy |
| echasnovski/mini.nvim | 平滑动画、智能删 buffer、缩进范围高亮 | VeryLazy |
| stevearc/oil.nvim | 像编辑 buffer 一样操作文件系统（`-`） | 按键 |
| mikavilpas/yazi.nvim | Yazi 文件管理器（`<leader>-`） | VeryLazy |
| ThePrimeagen/harpoon | 快速标记/切换文件 | VeryLazy |
| folke/persistence.nvim | 会话保存与恢复 | BufReadPre |
| uga-rosa/ccc.nvim | 颜色选择器（`<leader>cp`） | 按键 |
| OXY2DEV/markview.nvim | Markdown 可视化渲染 | ft=markdown |
| iamcco/markdown-preview.nvim | 浏览器预览 Markdown（`<leader>mp`） | 命令 |
| folke/todo-comments.nvim | 高亮 TODO/FIXME 并聚合到 Trouble | VeryLazy |
| mbbill/undotree | 可视化撤销树（`<leader>U`） | 按键 |
| MagicDuck/grug-far.nvim | 项目级查找替换（`<leader>fG`） | 按键 |
| stevearc/overseer.nvim | 任务运行器（`<leader>o*`） | 命令 |

### 搜索与导航

| 插件 | 作用 | 加载方式 |
| --- | --- | --- |
| folke/which-key.nvim | 快捷键提示向导 | VeryLazy |
| folke/snacks.nvim (picker) | 文件/内容/符号/诊断等所有模糊搜索 | 启动 |
| stevearc/aerial.nvim | 符号大纲（`<leader>a`） | 按键 |
| folke/trouble.nvim | 诊断/符号/引用列表 | 命令 |
| dnlhc/glance.nvim | 定义/引用/类型定义预览 | 命令 |

### LSP 与补全

| 插件 | 作用 | 加载方式 |
| --- | --- | --- |
| williamboman/mason.nvim | LSP/工具安装器 | 命令 |
| williamboman/mason-lspconfig.nvim | Mason 与 lspconfig 桥接，自动启用已装 server | BufReadPre |
| neovim/nvim-lspconfig | LSP 客户端配置 | 依赖 |
| hrsh7th/nvim-cmp + 各 source | 补全（LSP/路径/buffer/命令） | 启动 |
| L3MON4D3/LuaSnip + friendly-snippets | 代码片段引擎与片段库 | 启动 |
| stevearc/conform.nvim | 保存时按文件类型格式化 | BufWritePre |
| 内置 inlay hints | LSP 行内类型提示（自动开启 + `<leader>uh`） | LspAttach |

已配置的 LSP server：`lua_ls`、`pyright`、`clangd`、`ts_ls`、`bashls`、
`html`、`cssls`、`jsonls`、`yamlls`（rust-analyzer 由 rustaceanvim 管理）。

### Git

| 插件 | 作用 | 加载方式 |
| --- | --- | --- |
| lewis6991/gitsigns.nvim | 行内增删改标记、hunk 跳转 | BufReadPre |
| sindrets/diffview.nvim | Git 差异/文件历史查看 | 命令 |
| snacks (lazygit/gitbrowse) | 终端 lazygit、GitHub 链接跳转 | 按键 |

### 测试 / 调试 / 构建

| 插件 | 作用 | 加载方式 |
| --- | --- | --- |
| nvim-neotest/neotest + python/rust/plenary 适配器 | 测试运行/调试/总览 | VeryLazy |
| mfussenegger/nvim-dap | 调试协议（codelldb） | 命令 |
| rcarriga/nvim-dap-ui | 调试界面 | 依赖 |
| theHamsta/nvim-dap-virtual-text | 调试时变量虚拟文本 | 依赖 |
| Weissle/persistent-breakpoints.nvim | 断点持久化 | 依赖 |
| jay-babu/mason-nvim-dap.nvim | 自动安装 codelldb | 依赖 |
| mrcjkb/rustaceanvim | Rust 专用 LSP/调试配置 | ft=rust |
| saecki/crates.nvim | Cargo.toml 依赖版本管理 | ft=rust/toml |
| akinsho/flutter-tools.nvim | Flutter 开发支持 | ft=dart |

## 快捷键大全

> `<leader>` = 空格键。`n`=普通、`v`=可视、`i`=插入、`x`=字符可视、`o`=操作符待决。

### 基础操作

| 按键 | 模式 | 作用 |
| --- | --- | --- |
| `<leader>w` / `<leader>q` / `<leader>Q` | n | 保存 / 退出 / 全部退出 |
| `jj` | i | 退出插入模式 |
| `<Esc>` | n | 清除搜索高亮 |
| `<C-u>` | n | 向上翻半页并居中 |
| `gG` | n/v | 跳到最后一行 |
| `<A-k>` / `<A-i>` | n/v | 下移 / 上移当前行（选中） |
| `<` / `>` | v | 缩进并保持选中 |
| `p` | v | 粘贴且不覆盖寄存器 |
| `s` | n/x/o | Flash 字符跳转 |

### 窗口操作（`<leader>W`）

| 按键 | 作用 |
| --- | --- |
| `<leader>Wv` / `<leader>Wh` | 垂直 / 水平分割 |
| `<leader>Wc` / `<leader>Wo` | 关闭窗口 / 只留当前 |
| `<leader>Wr` / `<leader>Wm` / `<leader>W=` | 旋转 / 最大化 / 均衡 |
| `<A-方向键>` | 窗口间跳转 |
| `<A-->` / `<A-=>` | 宽度 -10 / +10 |
| `<A-S-->` / `<A-S-=>` | 高度 -10 / +10 |

### Buffer 操作（`<leader>b`）

| 按键 | 作用 |
| --- | --- |
| `<leader>bc` | 智能关闭当前 buffer（自动切换相邻，保存后删除） |
| `<leader>bo` / `<leader>bl` / `<leader>br` | 关闭其他 / 左侧 / 右侧 |
| `<leader>bh` / `<leader>bn` | 左移 / 右移 buffer |
| `<S-j>` / `<S-l>` | 上一个 / 下一个 buffer |

### 搜索（`<leader>f`）

| 按键 | 作用 |
| --- | --- |
| `<leader><space>` | 智能查找 |
| `<leader>ff` / `<leader>fb` / `<leader>fr` / `<leader>fp` | 文件 / buffer / 最近 / 项目 |
| `<leader>fg` / `<leader>/` | 全局搜索 |
| `<leader>fG` | 全局查找替换（grug-far，n/v） |
| `<leader>fw` | 搜索光标下单词 |
| `<leader>fc` | 当前文件行搜索 |
| `<leader>fs` / `<leader>fS` | 文件符号 / 工作区符号 |
| `<leader>fh` / `<leader>fk` / `<leader>f:` | 帮助 / 快捷键 / 命令 |
| `<leader>fd` | 诊断列表 |
| `<leader>f/` / `<leader>:` | 继续搜索 / 命令历史 |
| `<leader>ft` | TODO 列表 |

### 文件与目录

| 按键 | 作用 |
| --- | --- |
| `<leader>e` | Snacks 资源管理器 |
| `-` | Oil 文件系统（buffer 风格编辑） |
| `<leader>-` | Yazi 文件管理器 |
| `<leader>cR` | 重命名文件（含引用） |
| `<leader>.` / `<leader>S` | 暂存 buffer / 选择暂存 |

### Git（`<leader>g`）

| 按键 | 作用 |
| --- | --- |
| `<leader>gg` | 打开 lazygit |
| `<leader>gB` | Git 浏览器（复制链接） |
| `<leader>dv` / `<leader>dh` | Diff 视图 / 文件历史 |
| `]h` / `[h` | 下一个 / 上一个 hunk |

### LSP 与代码导航

| 按键 | 作用 |
| --- | --- |
| `K` | 悬浮文档 |
| `gd` / `gD` | Glance 定义预览 / 直接跳转定义 |
| `gR` / `gY` / `gM` | 引用 / 类型定义 / 实现 |
| `[d` / `]d` | 上一条 / 下一条诊断 |
| `<leader>ca` / `<leader>dq` | 代码动作 |
| `<leader>rn` | 重命名符号 |
| `<leader>lf` | 格式化当前文件 |
| `<leader>a` | 符号大纲 |

### 诊断 / 修复（`<leader>x`）

| 按键 | 作用 |
| --- | --- |
| `<leader>xx` / `<leader>xX` | Trouble 全部 / 当前文件诊断 |
| `<leader>xL` / `<leader>xQ` | 位置列表 / 快速修复列表 |
| `<leader>cs` / `<leader>cl` | Trouble 符号 / LSP 引用 |
| `<leader>dd` | 当前行诊断浮窗 |
| `<leader>dD` | 工作区诊断 |

### 调试与构建（`<leader>d`、`<leader>c`）

| 按键 | 作用 |
| --- | --- |
| `<leader>dc` / `<leader>do` / `<leader>di` / `<leader>dx` | 继续 / 单步跳过 / 进入 / 退出 |
| `<leader>dk` / `<leader>dK` | 断点 / 条件断点 |
| `<leader>dr` / `<leader>du` | REPL / 调试 UI |
| `<leader>cd` / `<leader>cb` / `<leader>cr` | C++ 构建并调试 / 构建 / 构建并运行 |

### 测试（`<leader>t`）

| 按键 | 作用 |
| --- | --- |
| `<leader>tr` / `<leader>tf` | 运行最近测试 / 当前文件测试 |
| `<leader>td` | 调试最近测试 |
| `<leader>ts` / `<leader>to` | 测试总览 / 测试输出 |

### 任务（`<leader>o`）

| 按键 | 作用 |
| --- | --- |
| `<leader>or` / `<leader>ol` / `<leader>oo` | 运行任务 / 任务列表 / 快速操作 |

### Rust（`<leader>r`）

| 按键 | 作用 |
| --- | --- |
| `<leader>rr` / `<leader>rt` / `<leader>rd` | 运行 / 测试 / 调试 |
| `<leader>re` / `<leader>rc` | 解释错误 / 打开 Cargo.toml |
| `<leader>rR` | 重启 rust-analyzer |
| `<leader>ru` / `<leader>rU` / `<leader>rs` | 更新依赖 / 升级全部 / crate 详情 |

### Harpoon（`<leader>h`）

| 按键 | 作用 |
| --- | --- |
| `<leader>hm` / `<leader>ha` | 菜单 / 标记当前文件 |
| `<leader>hh` / `<leader>hj` / `<leader>hk` / `<leader>hl` | 快速打开文件 1-4 |
| `<leader>hp` / `<leader>hn` / `<leader>hL` | 上一个 / 下一个 / 清空 |

### 开关与工具（`<leader>u`、`<leader>p`）

| 按键 | 作用 |
| --- | --- |
| `<leader>us` / `<leader>uw` | 拼写检查 / 自动换行 |
| `<leader>ud` / `<leader>ug` | 诊断 / 缩进线开关 |
| `<leader>uD` / `<leader>uh` | 聚焦模式 / 行内提示 |
| `<leader>pl` / `<leader>pm` | 插件管理 / LSP 工具管理 |
| `<leader>ps` / `<leader>pd` | 恢复上次会话 / 停止保存 |
| `<leader>n` | 通知历史 |
| `<leader>mp` | Markdown 预览 |
| `<leader>cp` | 颜色选择器 |
| `<leader>U` | 撤销树 |

### 补全（插入模式）

| 按键 | 作用 |
| --- | --- |
| `<C-j>` / `<C-k>` | 下一个 / 上一个候选项 |
| `<C-b>` / `<C-f>` | 文档滚动 |
| `<C-/>` | 手动触发补全 |
| `<CR>` | 确认选中项 |

### 折叠

| 按键 | 作用 |
| --- | --- |
| `zR` / `zM` | 展开 / 关闭所有折叠 |
| `zc` / `zo` / `za` | 关闭 / 展开 / 切换当前折叠 |

## 常用维护命令

| 命令 | 作用 |
| --- | --- |
| `:Lazy sync` | 安装 / 更新 / 清理插件 |
| `:Lazy clean` | 删除配置中不再引用的插件 |
| `:Lazy update` | 更新全部插件 |
| `:Mason` | LSP / DAP 工具管理 |
| `:TSUpdate` | 更新 tree-sitter 解析器 |
| `:ConformInfo` | 查看格式化工具状态 |

## 说明

- AI 补全（copilot.lua / CopilotChat.nvim）与已禁用的 neocodeium / llama.vim
  已从配置中移除；如需 AI 补全可重新引入。
- inlay hints 使用 Neovim 内置实现（0.10+），无需第三方插件。
- 诊断/导航类功能由 Trouble、Glance、aerial 与 LSP 内置完成（Lspsaga 已移除）。
