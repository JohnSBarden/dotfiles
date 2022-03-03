#!/usr/bin/env bash

_baselibs(){
    sudo apt update -y
    sudo apt upgrade -y
    sudo apt install curl git autoconf build-essential 
    git config --global core.excludesfile ~/.gitignore.global
}

_vim() {
    # install as fallback just in case
    sudo apt install -y vim
    sudo apt-add-repository ppa:neovim-ppa/stable
    sudo apt update
    sudo apt install -y neovim
}


_i3() {
    sudo apt install -y i3 i3lock rofi scrot maim xclip xdotool
}

_nord(){
    wget https://github.com/EliverLara/Nordic/releases/download/2.0.0/Nordic-darker-v40.tar.xz  && tar -xf ./Nordic-darker-v40.tar.xz -C ~/.themes/ && rm ./Nordic-darker-v40.tar.xz 
    wget https://dl2.pling.com/api/files/download/j/eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTY0MzkwODM2NSwidSI6bnVsbCwibHQiOiJkb3dubG9hZCIsInMiOiI0NjI0YTAxYzZhM2NmZjNhZmQ2OWQwYjM0ODRiYzI2YTg2OTk4MmE0NzJjN2Q1Zjc5NmRhYTZkNTVhNjVkZDJlN2U5ZGJkMGQzNmU3MGZkMDZjOGI5Y2IwMjg3ZDNlMmNkZTcxMGYyNGVhZGM0MDZiMmY0ZGQ0ZWNlMzMzMDJiNyIsInQiOjE2NDQ0MzA0OTUsInN0ZnAiOiJiNmUwODQ1ZDQ1MzZlNDM3ZWYzMGIwMmFjOWJlYzUwMyIsInN0aXAiOiIxMzYuNDAuMy4yMTcifQ.A1D1DBsyXlJgq93mxskdoNu5KZz5vGyKpFC74K8JM7U/Breeze-Nord-Dark-Icons.tar.gz && tar -xzf Breeze-Nord-Dark-Icons.tar.gz -C ~/.themes && rm Breeze-Nord-Dark-Icons.tar.gz
    ## Swap to theme
    gsettings set org.gnome.desktop.interface gtk-theme "Nordic Darker"
    gsettings set org.gnome.desktop.interface icon-theme "Breeze Nord Dark Icons"
}

_chromium() {
    sudo apt install -y chromium-browser
}

_virtualbox() {
   sudo apt install -y virtualbox
}

_minikube() {
    curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/
}

_go() {
    wget https://golang.org/dl/go1.14.6.linux-amd64.tar.gz && sudo tar -C /usr/local -xzf go1.14.6.linux-amd64.tar.gz
}

_rust() {
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

_kubeps1() {
    git clone https://github.com/jonmosco/kube-ps1.git $HOME/kube-ps1
}

_yarn() {
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt update && sudo apt install -y yarn
}

_fonts(){
    # sudo apt install fonts-firacode
    ## Fira Code Nerd Font (adds icons)
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
    unzip FiraCode.zip -d ~/.fonts
    fc-cache -fv
    echo "done!"
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
    curl -L https://github.com/docker/compose/releases/download/1.24.1/docker-compose-`uname -s`-`uname -m` > docker-compose && chmod +x docker-compose && sudo mv docker-compose /usr/local/bin/docker-compose
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
#    git clone https://github.com/powerline/fonts.git
    # install
#    cd fonts
#    ./install.sh
    # clean-up a bit
#   cd ..
#    rm -rf fonts
  
    sudo apt install -y fonts-powerline fonts-materialdesignicons-webfont
}

_powerline() {
    cd /tmp
    sudo apt install -y python3
    wget https://bootstrap.pypa.io/get-pip.py
    sudo python get-pip.py
    sudo pip install powerline-status
}

_addKube() {
    cd /tmp
  	curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.17.0/bin/linux/amd64/kubectl
	  chmod +x ./kubectl
    sudo mv ./kubectl /usr/local/bin/kubectl

    # add aws-iam-authenticator too

    curl -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.15.10/2020-02-22/bin/linux/amd64/aws-iam-authenticator
    chmod +x ./aws-iam-authenticator
    sudo mv ./aws-iam-authenticator /usr/local/bin/aws-iam-authenticator
}

_addAwsCli() {
    sudo apt install -y awscli
}

_addStern() {
    cd /tmp
  	curl -L https://github.com/wercker/stern/releases/download/1.11.0/stern_linux_amd64 > stern
  	chmod +x ./stern
    sudo mv ./stern /usr/local/bin/stern
}


_configureWatches() {
    echo fs.inotify.max_user_watches=512000 | sudo tee -a /etc/sysctl.conf
    sudo sysctl -p
}

_jetbrains-toolbox() {
    JETBRAINS_VERSION="jetbrains-toolbox-1.16.6319"
    wget https://download.jetbrains.com/toolbox/$JETBRAINS_VERSION.tar.gz &&
    tar -zxf $JETBRAINS_VERSION.tar.gz
    cd ./$JETBRAINS_VERSION
    chmod +x jetbrains-toolbox
    sudo mv jetbrains-toolbox /usr/local/bin/

}

_peco() {
    cd /tmp
    wget https://github.com/peco/peco/releases/download/v0.5.7/peco_linux_amd64.tar.gz &&
    tar -zxf peco_linux_amd64.tar.gz
    chmod +x peco_linux_amd64/peco
    sudo mv peco_linux_amd64/peco /usr/local/bin/peco
}

_polybar() {
  cd /tmp
  git clone --branch 3.2 --recursive https://github.com/jaagr/polybar
  mkdir polybar/build
  cd polybar/build
  sudo apt install -y cmake cmake-data libcairo2-dev libxcb1-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-image0-dev libxcb-randr0-dev libxcb-util0-dev libxcb-xkb-dev pkg-config python-xcbgen xcb-proto libxcb-xrm-dev i3-wm libasound2-dev libmpdclient-dev libiw-dev libcurl4-openssl-dev libpulse-dev libxcb-composite0-dev xcb libxcb-ewmh2
  cmake ..
  sudo make install
}

_desktopDeps() {
  sudo apt install -y dunst compton tree arandr slop xclip
}

_microsoftTeams() {
  cd /tmp
  wget https://teams.microsoft.com/downloads/desktopurl?env=production&plat=linux&arch=x64&download=true&linuxArchiveType=deb > /tmp/teams.deb
  sudo dpkg -i /tmp/teams.deb
  sudo apt update
  sudo apt upgrade -y
}

_exa() {
  # colorful ls utility
  cd /tmp
  wget https://github.com/ogham/exa/releases/download/v0.9.0/exa-linux-x86_64-0.9.0.zip &&
  unzip exa-linux-x86_64-0.9.0 &&
  chmod +x exa-linux-x86_64 &&
  sudo mv exa-linux-x86_64 /usr/local/bin/exai
}

_bat() {
   # colorful cat utility
   cd /tmp
   wget https://github.com/sharkdp/bat/releases/download/v0.15.0/bat_0.15.0_amd64.deb &&
   sudo dpkg -i bat_0.15.0_amd64.deb
}

_peek() {
   # peek is a screen capture / gif recording software
   sudo add-apt-repository ppa:peek-developers/stable
   sudo apt update
   sudo apt install -y peek
}

#always
_baselibs

# deprecated - yarn should be installed via npm install -g yarn
# _yarn
_vim
_install-zsh
_powerlinefont
_vundle
_docker  
_addAwsCli
_addKube
_addStern
_peco
_exa
_bat
_go
_rust

# additional libs if desktop
if [[ ! -z "$DESKTOP_SESSION" ]]; then
  _i3
  ## Choose a theme
  _nord
  ##
  _desktopDeps
  _polybar
  _chromium
  _virtualbox
  _minikube
  # _jetbrains-toolbox
  _configureWatches
  # _microsoftTeams
  _peek
  _fonts
fi

echo
echo
echo
echo
echo "==========================="
echo "Everything went ok - Reboot!"
echo "==========================="
