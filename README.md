# Neovim Configuration

基于 lazy.nvim 的模块化 Neovim 配置，要求 Neovim >= 0.11。

完整的插件清单和维护说明见 [NVIM_CONFIG.md](NVIM_CONFIG.md)。详细的中文快捷键学习手册见 [KEYMAPS.md](KEYMAPS.md)。

## 功能亮点

- 多语言运行 / 测试 / 调试：Rust、Python、C/C++、Shell、Lua、JS/TS、Go
  （`<leader>rf` 运行当前文件，`<leader>dc` 调试，`<leader>t*` 测试，`<leader>m*` CMake 构建）
- 内置终端：`<leader>tt` 或 `<C-\>` 在当前路径打开 / 切换终端
- Vim 标签页管理：`<leader>Tn` / `<leader>Tx` / `<leader>To`

## 安装

```bash
mv ~/.config/nvim ~/.config/nvim.bak
git clone https://github.com/emoeem/neovim.git ~/.config/nvim
nvim
```

首次启动会自动安装插件。若安装中断，执行 `:Lazy sync`。

## 依赖

- Neovim >= 0.11
- Git、ripgrep、fd、unzip
- Nerd Font（推荐，用于图标显示）
