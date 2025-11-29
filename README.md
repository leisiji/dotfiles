# My dotfiles

My dotfiles for Arch linux.

## Installation

I'm using stow to manage my dotfiles.

Minimal development on terminal:

```bash
sudo pacman -S \
    zsh fzf universal-ctags duf dust global glow rust-analyzer gopls \
    jq bat ripgrep fd eza hexyl lazygit yazi zoxide bottom starship atuin \
    cmake-language-server stylua clang tmux bear lua-language-server \
    neovim bun termusic
cargo install thumbs
```

language-server, linter, formatter

```bash
bun add --global \
    bash-language-server vim-language-server \
    markdownlint-cli2 pyright typescript git-split-diffs \
    typescript-language-server vscode-json-languageserver
cd $HOME/.bun/bin/ && ls | xargs sed -i "1s/\/usr\/bin\/env node/\/usr\/bin\/env bun/"

paru -S \
    kotlin-language-server \
    groovy-language-server-git \
    jdtls bun \
    google-java-format
```

Chinese input method:

```bash
sudo pacman -S fcitx5-im fcitx5-rime fcitx5-chinese-addons
# font: https://github.com/subframe7536/maple-font
```

Plugin Manager:

```bash
# packer.nvim
mkdir -p ~/.local/share/nvim/lazy/
git clone https://github.com/folke/lazy.nvim.git \
    ~/.local/share/nvim/lazy/lazy.nvim/
```

hyprland

```bash
sudo pacman -S xdg-desktop-portal-hyprland xdg-desktop-portal-hyprland hyprpaper dunst \
               wofi wlogout ghostty
```

software can also be downloaded from below links:

- [fzf](https://github.com/junegunn/fzf/releases)
- [duf](https://github.com/muesli/duf/releases)
- [ripgrep](https://github.com/BurntSushi/ripgrep/releases)
- [fd](https://github.com/sharkdp/fd/releases)
- [eza](https://github.com/eza-community/eza/releases)
- [yazi](https://github.com/sxyazi/yazi/releases/)
- [zoxide](https://github.com/ajeetdsouza/zoxide/releases)
- [starship](https://github.com/starship/starship/releases)
- [neovim](https://github.com/neovim/neovim/releases)
- [tmux](https://github.com/kiyoon/tmux-appimage/releases)
- [clang](https://github.com/llvm/llvm-project/releases)
- [patchelf](https://github.com/NixOS/patchelf/releases/)
