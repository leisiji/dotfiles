# My dotfiles

My dotfiles for Arch linux.

## Installation

I'm using stow to manage my dotfiles.

Minimal development on terminal:

```bash
sudo pacman -S \
    zsh fzf tmux universal-ctags duf dust global glow \
    bear lua-language-server rust-analyzer gopls \
    clang stylua jq hexyl bat ripgrep fd eza gitui joshuto zoxide bottom
```

language-server, linter, formatter

```bash
bun add --global \
    bash-language-server vim-language-server \
    markdownlint-cli pyright typescript git-split-diffs \
    typescript-language-server vscode-json-languageserver

paru -S \
    kotlin-language-server \
    groovy-language-server-git \
    jdtls bun \
    google-java-format

pip3 install --user cmake-language-server black
```

Chinese input method:

```bash
sudo pacman -S fcitx5 fcitx5-rime fcitx5-qt fcitx5-gtk fcitx5-chinese-addons \
     ttf-cascadia-code-nerd
```

Plugin Manager:

```bash
# packer.nvim
mkdir ~/.local/share/nvim/lazy/
git clone https://github.com/folke/lazy.nvim.git \
    ~/.local/share/nvim/lazy/lazy.nvim/
```
