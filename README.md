# My dotfiles

My dotfiles for Arch linux.

## Installation

I'm using stow to manage my dotfiles

Software dependencies:
```bash
# yay installation
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

# desktop basic
sudo pacman -S zathura zathura-pdf-mupdf i3 alacritty \
				adobe-source-code-pro-fonts
yay -S vnote i3status-rust nerd-fonts-complete

# shell related, lua is for z.lua
# w3m can display image in terminal
sudo pacman -S zsh exa fzf ranger tmux diff-so-fancy bat lua w3m

# neovim related, nodejs is for coc-nvim
sudo pacman -S neovim ripgrep nodejs bear
pip3 install --user pynvim
yay -S ccls
```
pip:
```bash
pip3 install --user \
			cmake-language-server jedi pynvim
```

Plugin Manager:
```bash
# vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# zplugin
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
```

