#!/usr/bin/env bash

_baselibs(){
    sudo apt update -y
    sudo apt upgrade -y
    sudo apt install curl git
    git config --global core.excludesfile ~/.gitignore.global
}

_exa(){
    wget https://github.com/ogham/exa/releases/download/v0.8.0/exa-linux-x86_64-0.8.0.zip
    unzip exa-linux-x86_64-0.8.0.zip
    sudo mv exa-linux-x86_64 /usr/local/bin
}

_vim() {
    # install as fallback just in case
    sudo apt install -y vim
    sudo apt-add-repository ppa:neovim-ppa/stable
    sudo apt update
    sudo apt install -y neovim
}

_i3() {
    sudo apt install -y i3 i3lock
}

_chromium() {
    sudo apt install -y chromium-browser
}

_virtualbox() {
   sudo apt install -y virtualbox
}

_minikube() {
    curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.24.1/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/
}


_kubeps1() {
    git clone https://github.com/jonmosco/kube-ps1.git $HOME/kube-ps1
}

_yarn() {
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt update && sudo apt install -y yarn
}

_docker(){
 sudo apt install -y \
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

    sudo apt update
    sudo apt install -y docker-ce
    sudo groupadd docker
    sudo usermod -aG docker $USER
    curl -L https://github.com/docker/compose/releases/download/1.23.1/docker-compose-`uname -s`-`uname -m` > docker-compose && chmod +x docker-compose && sudo mv docker-compose /usr/local/bin/docker-compose
}

_vundle(){
    # only install if we havent already
    if [ ! -d "~/.vim/bundle/" ]; then
      git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
      vim +PluginInstall +qall
    fi
  }

_install-zsh(){
    clear
    sudo apt install -y git
    sudo apt update && sudo apt install -y zsh
    
    echo "Changing Shell:"
    chsh -s $(which zsh)
}

_powerlinefont() {
    git clone https://github.com/powerline/fonts.git
    # install
    cd fonts
    ./install.sh
    # clean-up a bit
    cd ..
    rm -rf fonts
}

_powerline() {
    sudo apt install -y python3.6
    wget https://bootstrap.pypa.io/get-pip.py
    sudo python get-pip.py
    sudo pip install powerline-status
}

_addkube() {
  	curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.7.0/bin/linux/amd64/kubectl
	chmod +x ./kubectl
    sudo mv ./kubectl /usr/local/bin/kubectl
}

_configureWatches() {
    echo fs.inotify.max_user_watches=512000 | sudo tee -a /etc/sysctl.conf
    sudo sysctl -p
}

_jetbrains-toolbox() {
    JETBRAINS_VERSION="jetbrains-toolbox-1.12.4481"
    wget https://download.jetbrains.com/toolbox/$JETBRAINS_VERSION.tar.gz &&
    tar -zxf $JETBRAINS_VERSION.tar.gz
    ./$JETBRAINS_VERSION/jetbrains-toolbox
}

_peco() {
    wget https://github.com/peco/peco/releases/download/v0.5.3/peco_linux_amd64.tar.gz &&
    tar -zxf peco_linux_amd64.tar.gz
    chmod +x peco_linux_amd64/peco
    sudo mv peco_linux_amd64/peco /usr/local/bin/peco
}

#always
_baselibs
_yarn
_vim
_install-zsh
_powerlinefont
_vundle
_docker  
_addkube

# additional libs if desktop
if [ -z "$DESKTOP_SESSION" ]; then
  _i3
  _chromium
  _virtualbox
  _minikube
  _jetbrains-toolbox
  _configureWatches
fi

echo "==========================="
echo "Everything went ok - Reboot!"
