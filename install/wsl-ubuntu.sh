sudo apt install -y stow
stow -d ~/.dotfiles/oh-my-zsh -S wsl_ubuntu -t ~/
stow -d ~/.dotfiles/vscode-server -S wsl-ubuntu -t ~/
stow -d ~/.dotfiles/git/ -S personal -t ~/
