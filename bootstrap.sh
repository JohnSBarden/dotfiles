#!/usr/bin/env bash

baselibs(){
    sudo apt-get update -y
    sudo apt-get upgrade -y
    git config --global core.excludesfile ~/.gitignore.global
}

exa(){
    wget https://github.com/ogham/exa/releases/download/v0.8.0/exa-linux-x86_64-0.8.0.zip
    unzip exa-linux-x86_64-0.8.0.zip
    sudo mv exa-linux-x86_64 /usr/local/bin
}

vim() {
    # install as fallback just in case
    sudo apt-get install -y vim
    sudo apt-add-repository ppa:neovim-ppa/stable
    sudo apt-get update
    sudo apt-get install neovim
}

i3() {
    sudo apt-get install -y i3 i3lock
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


kubeps1() {
    git clone https://github.com/jonmosco/kube-ps1.git $HOME/kube-ps1
}

yarn() {
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt-get update && sudo apt-get install -y yarn
}

nvm() {
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash
}


docker(){
    sudo apt-get install -y \
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
    sudo apt-get install -y docker-ce
    sudo groupadd docker
    sudo usermod -aG docker $USER
    curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` > docker-compose && chmod +x docker-compose && sudo mv docker-compose /usr/local/bin/docker-compose
}

vundle(){
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall
}

_install-zsh(){
    clear
    sudo apt-get install -y git
    sudo apt-get update && sudo apt-get install -y zsh
    
    echo "Changing Shell:"
    chsh -s $(which zsh)
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
    sudo apt-get install -y python3.6
    wget https://bootstrap.pypa.io/get-pip.py
    sudo python get-pip.py
    sudo pip install powerline-status
}

addkube() {
	curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.7.0/bin/linux/amd64/kubectl
	chmod +x ./kubectl
    sudo mv ./kubectl /usr/local/bin/kubectl
}

configureWatches() {
    echo fs.inotify.max_user_watches=512000 | sudo tee -a /etc/sysctl.conf
    sudo sysctl -p
}

_jetbrains-toolbox() {
    JETBRAINS_VERSION="jetbrains-toolbox-1.6.2914"
    wget https://download.jetbrains.com/toolbox/$JETBRAIN_VERSION.tar.gz &&
    tar -zxf $JETBRAINS_VERSION.tar.gz
    ./$JETBRAINS_VERSION/jetbrains-toolbox
}

#always
baselibs
yarn
nvm
vim
_install-zsh
powerlinefont
powerline
vundle
docker  
addkube

# additional libs if desktop
if [ $DESKTOP_SESSION ]; then
i3
chromium
virtualbox
minikube
_jetbrains-toolbox
configureWatches
fi

echo "==========================="
echo "Everything went ok - Reboot!"
