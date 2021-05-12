# My dotfiles

My dotfiles for Arch linux.

## Installation

I'm using stow to manage my dotfiles.

Minimal development on terminal:

```sh
# yay installation
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

# shell related, lua is for z.lua
# ueberzug can display image in terminal
sudo pacman -S zsh fzf nnn tmux lua ueberzug universal-ctags global xclip

# neovim related
sudo pacman -S neovim nodejs npm bear yarn
yay -S glow

# language-server, linter
yarn global add bash-language-server vim-language-server \
            diagnostic-languageserver markdownlint-cli pyright
yay -S ccls kotlin-language-server lua-language-server-git \
        groovy-language-server-git jdtls
pip3 install --user cmake-language-server

pip3 install --user pynvim compiledb

# tools based on rust
cargo install hexyl bat ripgrep fd-find exa git-delta gitui
```

Desktop:

```sh
sudo pacman -S zathura zathura-pdf-mupdf alacritty
yay -S vnote nerd-fonts-source-code-pro

# i3
sudo pacman -S i3 i3status-rust xdotool rofi
yay -S alsa-utils ttf-font-awesome powerline-fonts
```

Chinese input method:

```sh
sudo pacman -S fcitx5 fcitx5-rime fcitx5-qt fcitx5-gtk fcitx5-chinese-addons \
        fcitx5-material-color adobe-source-han-sans-otc-fonts
```

Plugin Manager:

```sh
# packer.nvim
git clone https://github.com/wbthomason/packer.nvim \
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# zinit
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
```

