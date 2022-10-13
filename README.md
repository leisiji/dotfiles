# My dotfiles

My dotfiles for Arch linux.

## Installation

I'm using stow to manage my dotfiles.

Minimal development on terminal:

```bash
# yay installation
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

# ueberzug can display image in terminal
sudo pacman -S zsh fzf tmux lua ueberzug universal-ctags global xclip clang

# neovim related
sudo pacman -S neovim nodejs npm bear yarn
yay -S glow nnn-nerd

pip3 install --user pynvim compiledb

# tools based on rust
cargo install hexyl bat ripgrep fd-find exa git-delta gitui
```

language-server, linter, formatter

```bash
yarn global add \
    bash-language-server \
    vim-language-server \
    markdownlint-cli \
    pyright \
    diagnostic-languageserver \
    typescript-language-server \
    typescript

yay -S \
    clang \
    kotlin-language-server \
    lua-language-server-git \
    groovy-language-server-git \
    jdtls \
    gopls \
    google-java-format \
    cppcheck

pip3 install --user cmake-language-server black

cargo install stylua
```

Desktop:

```bash
sudo pacman -S zathura zathura-pdf-mupdf alacritty
yay -S vnote nerd-fonts-source-code-pro

# i3
sudo pacman -S i3 i3status-rust xdotool rofi
yay -S alsa-utils ttf-font-awesome powerline-fonts
```

Chinese input method:

```bash
sudo pacman -S fcitx5 fcitx5-rime fcitx5-qt fcitx5-gtk fcitx5-chinese-addons \
        fcitx5-material-color adobe-source-han-sans-otc-fonts
```

Plugin Manager:

```bash
# packer.nvim
git clone https://github.com/wbthomason/packer.nvim \
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# zinit
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
```
