#!/bin/bash

echo "$(whoami)"
[ "$UID" -eq 0 ] || exec sudo "$0" "$@"

sudo apt-get --assume-yes update

sudo apt-get --assume-yes install xclip
echo 'cpfile(){
  readlink -f "$1" | xclip -selection clipboard
}' >> ~/.bashrc

sudo apt-get --assume-yes install git
cp ./.gitconfig ~

ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub | xclip -selection clipboard

sudo apt-get --assume-yes install vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cp ./.vimrc ~
vim +PlugInstall +qall

echo 'set -o vi
bind -m vi-insert "\C-l":clear-screen' >> ~/.bashrc

sudo apt-get --assume-yes install tmux
cp ./.tmux.conf ~

sudo apt-get --assume-yes install ranger
echo "source /usr/share/doc/fzf/examples/key-bindings.bash" >> ~/.bashrc
echo "source /usr/share/doc/fzf/examples/completion.bash" >> ~/.bashrc

sudo apt-get --assume-yes install fzf
echo "export FZF_DEFAULT_COMMAND='find .'" >> ~/.bashrc
echo 'export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"' >> ~/.bashrc

sudo apt-get --assume-yes install neofetch
sudo apt-get --assume-yes install htop
sudo apt-get --assume-yes install nmap
sudo apt-get --assume-yes install trash-cli

source ~/.bashrc
