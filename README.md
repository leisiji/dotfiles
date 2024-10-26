# My dotfiles

My dotfiles for Arch linux.

## Installation

I'm using stow to manage my dotfiles.

Minimal development on terminal:

```bash
sudo pacman -S \
    zsh fzf universal-ctags duf dust global glow rust-analyzer gopls \
    jq bat ripgrep fd eza hexyl gitui joshuto zoxide bottom starship \
    cmake-language-server stylua clang tmux bear lua-language-server \
    neovim bun
```

language-server, linter, formatter

```bash
bun add --global \
    bash-language-server vim-language-server \
    markdownlint-cli2 pyright typescript git-split-diffs \
    typescript-language-server vscode-json-languageserver

paru -S \
    kotlin-language-server \
    groovy-language-server-git \
    jdtls bun \
    google-java-format
```

Chinese input method:

```bash
sudo pacman -S fcitx5-im fcitx5-rime fcitx5-chinese-addons ttf-cascadia-code-nerd
```

Plugin Manager:

```bash
# packer.nvim
mkdir -p ~/.local/share/nvim/lazy/
git clone https://github.com/folke/lazy.nvim.git \
    ~/.local/share/nvim/lazy/lazy.nvim/
```
