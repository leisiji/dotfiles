# My dotfiles

My dotfiles for Arch linux.

## Installation

I'm using stow to manage my dotfiles.

Minimal development on terminal:

```bash
# ueberzug can display image in terminal
sudo pacman -S \
    zsh fzf tmux universal-ctags \
    global glow \
    neovim nodejs bear yarn \
    lua-language-server clang rust-analyzer gopls \
    clang stylua jq \
    hexyl bat ripgrep fd-find eza gitui joshuto zoxide \
    duf dust

pip3 install --user pynvim scan-build
```

language-server, linter, formatter

```bash
bun add --global \
    bash-language-server \
    vim-language-server \
    markdownlint-cli \
    pyright \
    typescript-language-server \
    vscode-json-languageserver \
    typescript \
    git-split-diffs

paru -S \
    kotlin-language-server \
    groovy-language-server-git \
    jdtls \
    google-java-format

pip3 install --user cmake-language-server black
```

Chinese input method:

```bash
sudo pacman -S fcitx5 fcitx5-rime fcitx5-qt fcitx5-gtk fcitx5-chinese-addons \
        fcitx5-material-color ttf-cascadia-code-nerd
```

Plugin Manager:

```bash
# packer.nvim
mkdir ~/.local/share/nvim/lazy/
git clone https://github.com/folke/lazy.nvim.git \
    ~/.local/share/nvim/lazy/lazy.nvim/
```
