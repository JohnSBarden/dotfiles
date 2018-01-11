#!/usr/bin/env bash

baselibs(){
    sudo apt-get update -y
    sudo apt-get upgrade -y
    git config --global core.excludesfile ~/.gitignore.global
}

vim() {
    sudo apt-get install vim
}

i3() {
    sudo apt-get install i3 i3lock
}

chromium() {
    sudo apt-get install chromium-browser
}

virtualbox() {
    # todo prefer using a specific file so idempotent
    echo "deb http://download.virtualbox.org/virtualbox/debian xenial contrib" | sudo tee -a /etc/apt/sources.list
    wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
    wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
}

minikube() {
    curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.24.1/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/
}

kubectx() {
    git clone https://github.com/ahmetb/kubectx.git $HOME/kubectx
    ln -s $HOME/kubectx/kubectx $HOME/.bin/kubectx
    ln -s $HOME/kubectx/kubens $HOME/.bin/kubens
}

kubeps1() {
    git clone https://github.com/jonmosco/kube-ps1.git $HOME/kube-ps1
}

docker(){
    sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

    sudo apt-key fingerprint 0EBFCD88

    sudo add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
       $(lsb_release -cs) \
       stable"

    sudo apt-get update
    sudo apt-get install docker-ce
    sudo groupadd docker
    sudo usermod -aG docker $USER
    curl -L https://github.com/docker/compose/releases/download/1.14.0/docker-compose-`uname -s`-`uname -m` > docker-compose && chmod +x docker-compose && sudo mv docker-compose /usr/local/bin/docker-compose

}

vundle(){
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall
}

prezto(){
    clear
    sudo apt-get install -y git
    sudo apt-get update && sudo apt-get install -y zsh
    # Get prezto
    git clone --recursive https://github.com/sorin-ionescu/prezto.git ~/.zprezto

    # Backup zsh config if it exists
    if [ -f ~/.zshrc ];
       then
           mv ~/.zshrc ~/.zshrc.backup
    fi

    # Create links to zsh config files
    ln -s ~/.zprezto/runcoms/zlogin ~/.zlogin
    ln -s ~/.zprezto/runcoms/zlogout ~/.zlogout
    ln -s ~/.zprezto/runcoms/zpreztorc ~/.zpreztorc
    ln -s ~/.zprezto/runcoms/zprofile ~/.zprofile
    ln -s ~/.zprezto/runcoms/zshenv ~/.zshenv
    ln -s ~/.zprezto/runcoms/zshrc ~/.zshrc
    chsh -s $(which zsh)
}

antigen(){
    git clone https://github.com/zsh-users/antigen.git ~/antigen
}

ohmyzsh(){
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
}

powerlinefont() {
    git clone https://github.com/powerline/fonts.git
    # install
    cd fonts
    ./install.sh
    # clean-up a bit
    cd ..
    rm -rf fonts
}

powerline() {
    sudo apt-get install python3.6
    wget https://bootstrap.pypa.io/get-pip.py
    sudo python get-pip.py
    sudo pip install powerline-status
}

addkube() {
	curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.7.0/bin/linux/amd64/kubectl
	chmod +x ./kubectlsudo 
	mv ./kubectl /usr/local/bin/kubectl
}

configureWatches() {
    echo fs.inotify.max_user_watches=512000 | sudo tee -a /etc/sysctl.conf
    sudo sysctl -p
}

baselibs
vim
i3
chromium
prezto
powerlinefont
powerline
vundle
docker  
addkube
configureWatches


echo "==========================="
echo "Everything went ok - Reboot!"
0
