<p align="center">
<img src="https://raw.githubusercontent.com/thenickygee/oni/main/images/logo-small.png"/>
</p>

# Oni
A NeoVim personalized development evironment with a ronin aesthetic.


![desktop][desktop]

## Installation

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/thenickygee/oni/HEAD/install.sh)"
```
![installer][installer]

> **Supported Operating Systems:** MacOS, Linux

## Includes

- [**Oni-Nvim**](/nvim) A highly customized [NeoVim](https://neovim.io)
- [**WezTerm**](https://wezfurlong.org/wezterm/)
- [**tmux**](https://github.com/tmux/tmux/wiki)
- [**Language Servers:**](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)
  - [C](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#clangd)
  - [Go](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#gopls)
  - [Node](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tsserver)
  - [Python](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pyright)
  - [Rust](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer)
  - _Many others_ (Bash, Docker, Lua, Make, Protobuf, ...)
- [**Themes:**](https://github.com/topics/neovim-theme)
  - [rebelot/kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim) (default)
  - [folke/tokyonight](https://github.com/folke/tokyonight.nvim)
  - [catppuccin/nvim](https://github.com/catppuccin/nvim)
- [**NerdFonts:**](https://www.nerdfonts.com)
  - [hack](https://www.programmingfonts.org/#hack) (default)
  - [mononoki](https://www.programmingfonts.org/#mononoki)
  - [go-mono](https://www.programmingfonts.org/#go-mono)
  - [jetbrains-mono](https://www.programmingfonts.org/#jetbrains-mono)

## User Guide

```sh
nvim +Tutor
```

## Config Files

neovim    --> ${HOME}/.config/nvim
tmux      --> ${HOME}/.config/tmux
wezterm   --> ${HOME}/.config/wezterm
starship  --> ${HOME}/.config/starship

## Key Mappings

To view 'lead' mappings, open **nvim** and press `<Space>`:

![mappings][mappings]

> The `<Space>` key is the default _maplead_, change with: `vim.g.maplead = "<key>"`

### Navigation:

| Key Mapping  | Description                      |
| ------------ | -------------------------------- |
| `<Space>` o  | Open file explorer (tree view)   |
| `<Space>` ff | Fuzzy finder (find/open file)    |
| `<Shift>` l  | Next buffer (tab)                |
| `<Shift>` h  | Prev buffer (tab)                |
| `<Ctrl>` l   | Next window, right               |
| `<Ctrl>` h   | Next window, left                |
| `<Ctrl>` j   | Next window, down                |
| `<Ctrl>` k   | Next window, up                  |

neovim: help map
tmux list-keys
wezterm show-keys
bash: alias

> Download the [NeoVim Cheet Sheet][cheatsheet] for more NeoVim commands

## Configuration

- **Languages:** `:LspInstall [language]`
- **Linters:** `:MasonInstall <linter>`
- **Formatters:** `:MasonInstall <formatter>`
- **Fonts:** `brew install --cask font-<font>-nerd-font`

### Advanced Configuration:

Update the _user_ configuration file: `~/.config/nvim/lua/user/init.lua`

## Screenshots

![desktop2][desktop2]
![screen][screen]

[logo]: https://raw.githubusercontent.com/thenickygee/oni/main/images/logo.png
[logo-small]: https://raw.githubusercontent.com/thenickygee/oni/main/images/logo-small.png
[desktop]: https://raw.githubusercontent.com/thenickygee/oni/main/images/desktop.png
[desktop2]: https://raw.githubusercontent.com/thenickygee/oni/main/images/desktop2.png
[screen]: https://raw.githubusercontent.com/thenickygee/oni/main/images/screen.png
[mappings]: https://raw.githubusercontent.com/thenickygee/oni/main/images/mappings.png
[installer]: https://raw.githubusercontent.com/thenickygee/oni/main/images/installer.png

# oni
