#!/bin/bash

apt-get update

apt-get install xclip
echo 'cpfile(){
  readlink -f "$1" | xclip -selection clipboard
}' >> ~/.bashrc

apt-get install git
cp ./.gitconfig ~

ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub | xclip -selection clipboard

apt-get install vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cp ./.vimrc ~
vim +PlugInstall +qall

echo 'set -o vi
bind -m vi-insert "\C-l":clear-screen' >> ~/.bashrc

apt-get install tmux
cp ./.tmux.conf ~

apt-get install ranger
echo "source /usr/share/doc/fzf/examples/key-bindings.bash" >> ~/.bashrc
echo "source /usr/share/doc/fzf/examples/completion.bash" >> ~/.bashrc

apt-get install fzf
echo "export FZF_DEFAULT_COMMAND='find .'" >> ~/.bashrc
echo 'export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"' >> ~/.bashrc

apt-get install neofetch
apt-get install htop
apt-get install nmap
apt-get install trash-cli

source ~/.bashrc
