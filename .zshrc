#
# .zshrc config
#
# basic zsh/antigen, vim, golang, nvm, setup
#

# Grab antigen if we dont have it
if [[ ! -e $HOME/.antigen/antigen.zsh ]]; then
    git clone https://github.com/zsh-users/antigen.git ~/.antigen
fi

# source antigen now
source $HOME/.antigen/antigen.zsh

# grab our aliases if they exist
if [[ -e "${HOME}/.aliases" ]]; then
  source "${HOME}/.aliases"
fi

#default folder our NVM install goes to
export NVM_DIR="$HOME/.nvm"

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle pip
antigen bundle command-not-found
antigen bundle vundle
antigen bundle wd

# highlighting
antigen bundle zsh-users/zsh-syntax-highlighting

# kubernetes
antigen bundle kubectl
antigen bundle ahmetb/kubectx

# always been getting more efficient
antigen bundle djui/alias-tips

# preload nvm for node version management
antigen bundle lukechilds/zsh-nvm

#override ctrl to use peco for fuzzy searching of history
antigen bundle jimeh/zsh-peco-history

#lock screen, we bind to this in our i3 keybindings 
antigen bundle guimeira/i3lock-fancy-multimonitor

#load up teiler for imagie / screencasting
# todo :: 
# antigen bundle carnage/teiler

#our zsh theme, a popular powerline variant
antigen theme agnoster

# Tell antigen that you're done.
antigen apply

# stern completion
source <(stern --completion=zsh)

# add our personal bin to path
export PATH=$HOME/.bin/:$PATH

#powerline?
export POWERLINE_CONFIG_COMMAND=$HOME/.local/bin/powerline-config 

# add composer to path
export PATH=$PATH:~/.config/composer/vendor/bin/

#golang
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go

# add yarn to bin
export PATH=$PATH:`yarn global bin`

# configure editors
export VISUAL=vim
export EDITOR="$VISUAL"

# work variables
source ~/.intellifarms

# Silenced macro
# Runs the command in the background, with absolutely zero output.
silenced() {
    "$@" &> /dev/null &;
}
