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
| folke/flash.nvim | 快速跳转（按命令调用） | VeryLazy |
| echasnovski/mini.nvim | 平滑动画、智能删 buffer、缩进范围高亮 | VeryLazy |
| stevearc/oil.nvim | 像编辑 buffer 一样操作文件系统（`-`） | 按键 |
| mikavilpas/yazi.nvim | Yazi 文件管理器（`:Yazi`） | VeryLazy |
| ThePrimeagen/harpoon | 快速标记/切换文件 | VeryLazy |
| folke/persistence.nvim | 会话保存与恢复 | BufReadPre |
| uga-rosa/ccc.nvim | 颜色选择器（`:CccPick`） | 启动 |
| OXY2DEV/markview.nvim | Markdown 可视化渲染 | ft=markdown |
| iamcco/markdown-preview.nvim | 浏览器预览 Markdown（`:MarkdownPreviewToggle`） | 命令 |
| folke/todo-comments.nvim | 高亮 TODO/FIXME 并聚合到 Trouble | VeryLazy |
| mbbill/undotree | 可视化撤销树（`<leader>uu`） | 按键 |
| MagicDuck/grug-far.nvim | 项目级查找替换（`<leader>fR`） | 按键 |
| stevearc/overseer.nvim | 任务运行器（`<leader>o*`） | 命令 |

### 搜索与导航

| 插件 | 作用 | 加载方式 |
| --- | --- | --- |
| folke/which-key.nvim | 快捷键提示向导 | VeryLazy |
| folke/snacks.nvim (picker) | 文件/内容/符号/诊断等所有模糊搜索 | 启动 |
| stevearc/aerial.nvim | 符号大纲（`<leader>cs`） | 按键 |
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

## 快捷键

`<leader>` 是空格。所有自定义快捷键都以空格开始，不使用 `F1`-`F12` 或 Alt 组合键，因此不会与 Niri 的全局按键冲突。输入空格后可由 which-key 查看当前可用按键。

### 快捷键入口

| 前缀 | 作用 |
| --- | --- |
| `<Space>` | 自定义快捷键总入口；后接 `b/c/d/f/g/h/m/o/r/s/t/u/x` 进入对应功能组 |
| `g` | 代码导航与常用移动 |
| `z` | 代码折叠 |
| `[` / `]` | 跳到上一个 / 下一个诊断或 Git 修改 |
| `<S-Left>` / `<S-Right>` | 上一个 / 下一个缓冲区 |
| `<S-Up>` / `<S-Down>` | 上一个 / 下一个 Vim 标签页 |
| `<C-S-Left/Down/Up/Right>` | 切到左 / 下 / 上 / 右侧分屏窗口 |
| `<C-\\>` | 浮动终端 |
| `K` | 当前位置的语言服务文档 |
| `jj`（插入模式） | 退出插入模式 |

### 日常操作

| 按键 | 作用 |
| --- | --- |
| `<leader>w` / `<leader>q` / `<leader>Q` | 保存 / 退出 / 全部退出 |
| `jj`（插入模式） | 退出插入模式 |
| `<Esc>` | 清除搜索高亮 |
| `-` | Oil 文件浏览器 |
| `<C-\\>` | 打开或关闭浮动终端 |
| `<` / `>`（可视模式） | 缩进并保持选中 |
| `p`（可视模式） | 粘贴且不覆盖寄存器 |

### 窗口与缓冲区

| 按键 | 作用 |
| --- | --- |
| `<C-S-Left/Down/Up/Right>` | 跳转左 / 下 / 上 / 右窗口 |
| `<leader>sv` / `<leader>sh` | 垂直 / 水平分割 |
| `<leader>sx` / `<leader>so` | 关闭窗口 / 只保留当前窗口 |
| `<leader>se` / `<leader>sm` | 均衡 / 最大化窗口 |
| `<leader>bb` / `<leader>bd` / `<leader>bo` | 缓冲区列表 / 关闭当前 / 关闭其他 |
| `<S-Left>` / `<S-Right>` | 上一个 / 下一个缓冲区 |
| `1` 至 `9`（普通模式） | 直接切到顶部第 1 至第 9 个文件 |

顶部显示的一排文件名通常是 **缓冲区**，不是 Vim 标签页；要在这些文件之间切换，请使用 `<S-Left>`、`<S-Right>`，按 `1` 至 `9` 直达对应文件，或按 `<Space>bb` 从列表选择。分屏后，使用 `<C-S-Left>`、`<C-S-Down>`、`<C-S-Up>`、`<C-S-Right>` 进入目标窗口；之后可用缓冲区快捷键切换该窗口显示的文件。

### 分屏窗口

| 按键 | 作用 |
| --- | --- |
| `<C-S-Left>` / `<C-S-Down>` / `<C-S-Up>` / `<C-S-Right>` | 切到左 / 下 / 上 / 右侧窗口 |
| `<C-w>v` / `<C-w>s` | 左右 / 上下分屏 |
| `<C-w>c` / `<C-w>o` | 关闭当前窗口 / 只保留当前窗口 |
| `<Space>sv` / `<Space>sh` | 左右 / 上下分屏（自定义写法） |

### Vim 标签页

| 按键 | 作用 |
| --- | --- |
| `<S-Up>` / `<S-Down>` | 上一个 / 下一个标签页 |

> 数字键 `1` 至 `9` 已专门用于切换顶部文件栏中的缓冲区，因此不再作为重复次数前缀使用。

### 查找与文件

| 按键 | 作用 |
| --- | --- |
| `<leader>e` | 文件浏览器 |
| `<leader>ff` / `<leader>fr` | 查找文件 / 最近文件 |
| `<leader>fg` / `<leader>fw` | 全局搜索 / 搜索光标词或选区 |
| `<leader>fs` / `<leader>fh` / `<leader>fk` | 文件符号 / 帮助 / 快捷键 |
| `<leader>fR` | 项目级查找替换 |

### 代码与诊断

这些 LSP 键只在语言服务已附加的文件中生效。

| 按键 | 作用 |
| --- | --- |
| `K` | 悬浮文档 |
| `gd` / `gD` | 定义 / 声明 |
| `gr` / `gi` / `gy` | 引用 / 实现 / 类型定义 |
| `[d` / `]d` | 上一条 / 下一条诊断 |
| `<leader>ca` / `<leader>cr` / `<leader>cf` | 代码动作 / 重命名 / 格式化 |
| `<leader>cs` | 符号大纲 |
| `<leader>xd` / `<leader>xx` / `<leader>xX` | 当前诊断 / 工作区诊断 / 当前文件诊断 |

### Git 与调试

| 按键 | 作用 |
| --- | --- |
| `<leader>gg` / `<leader>gb` | Git 管理界面 / 浏览 Git 链接 |
| `<leader>gd` / `<leader>gh` | 查看差异 / 文件历史 |
| `[h` / `]h` | 上一处 / 下一处 Git 修改 |
| `<leader>dc` / `<leader>db` | 调试继续 / 切换断点 |
| `<leader>do` / `<leader>di` / `<leader>dO` | 单步跳过 / 进入 / 退出 |
| `<leader>dB` / `<leader>dr` / `<leader>du` | 条件断点 / 调试交互终端 / 调试界面 |
| `<leader>mb` / `<leader>mr` / `<leader>md` | C++ 构建 / 构建并运行 / 构建并调试 |

### 按需功能

| 按键 | 作用 |
| --- | --- |
| `<leader>tr` / `<leader>tf` / `<leader>td` | 测试最近项 / 当前文件 / 调试最近项 |
| `<leader>ts` / `<leader>to` | 测试总览 / 输出 |
| `<leader>rr` / `<leader>rt` / `<leader>rd` | Rust 运行 / 测试 / 调试（仅 Rust 文件） |
| `<leader>re` / `<leader>rc` | Rust 解释错误 / 打开 Cargo.toml（仅 Rust 文件） |
| `<leader>ha` / `<leader>hh` | 标记文件 / 打开标记列表 |
| `<leader>or` / `<leader>ol` / `<leader>oo` | 运行任务 / 任务列表 / 快速操作 |
| `<leader>us` / `<leader>uw` / `<leader>uh` / `<leader>uu` | 拼写 / 自动换行 / 行内提示 / 撤销树 |
| `<leader>l` / `<leader>M` / `<leader>n` | Lazy / Mason / 通知历史 |

### 补全与折叠

| 按键 | 作用 |
| --- | --- |
| `<C-j>` / `<C-k>`（插入模式） | 下一个 / 上一个补全项 |
| `<C-b>` / `<C-f>`（插入模式） | 补全文档滚动 |
| `<C-/>` / `<CR>`（插入模式） | 手动补全 / 确认 |
| `zR` / `zM` / `zc` / `zo` / `za` | 展开全部 / 关闭全部 / 关闭 / 展开 / 切换折叠 |

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

- AI 补全插件已从配置中移除，如需 AI 补全可单独引入。
- inlay hints 使用 Neovim 内置实现（0.10+），无需第三方插件。
- 诊断/导航类功能由 Trouble、Glance、aerial 与 LSP 内置完成（Lspsaga 已移除）。
