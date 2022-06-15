#!/bin/bash

if ! [ $(id -u) = 0 ]; then
   echo "The script need to be run as root." >&2
   exit 1
fi

if [ $SUDO_USER ]; then
    user=$SUDO_USER
else
    user=$(whoami)
fi

apt-get --assume-yes update

apt-get --assume-yes install xclip
echo 'cpfile(){
  readlink -f "$1" | xclip -selection clipboard
}' >> /home/$user/.bashrc

apt-get --assume-yes install git
cp ./.gitconfig ~
cat ./ps1.txt >> /home/$user/.bashrc

ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa

apt-get --assume-yes install vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cp ./.vimrc ~
vim +PlugInstall +qall

echo 'set -o vi
bind -m vi-insert "\C-l":clear-screen' >> /home/$user/.bashrc

apt-get --assume-yes install tmux
cp ./.tmux.conf ~

apt-get --assume-yes install ranger
echo "source /usr/share/doc/fzf/examples/key-bindings.bash" >> /home/$user/.bashrc
echo "source /usr/share/doc/fzf/examples/completion.bash" >> /home/$user/.bashrc

apt-get --assume-yes install fzf
echo "export FZF_DEFAULT_COMMAND='find .'" >> /home/$user/.bashrc
echo 'export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"' >> /home/$user/.bashrc

apt-get --assume-yes install neofetch
apt-get --assume-yes install htop
apt-get --assume-yes install nmap
apt-get --assume-yes install trash-cli

cat /home/$user/.ssh/id_rsa.pub
