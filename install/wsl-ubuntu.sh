sudo apt install -y stow
stow -d ~/.dotfiles/oh-my-zsh -S wsl-ubuntu -t ~/
stow -d ~/.dotfiles/vscode-server -S wsl-ubuntu -t ~/
stow -d ~/.dotfiles/git/ -S personal -t ~/
fzf/install
mkdir -p ~/.config.nvim
stow -d ~/.dotfiles -S nvim -t ~/
ln -s ~/.dotfiles/.zshrc ~/.zshrc
