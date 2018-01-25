#
# .zshrc config
#
# basic vim, golang, nvm, setup
#

# Grab antigen our zsh package manager
source $HOME/antigen/antigen.zsh

# grab our aliases if they exist
if [[ -e "${HOME}/.aliases" ]]; then
  source "${HOME}/.aliases"
fi

# gruvbox color theme
# pretty sure we can remove this
source "$HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh"

#default folder our NVM install goes to
export NVM_DIR="$HOME/.nvm"

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found
antigen bundle vundle
antigen bundle wd

antigen bundle kubectl
antigen bundle ahmetb/kubectx
antigen bundle djui/alias-tips
antigen bundle lukechilds/zsh-nvm
antigen bundle zsh-users/zsh-syntax-highlighting

antigen theme agnoster

# Tell antigen that you're done.
antigen apply

#powerline?
export POWERLINE_CONFIG_COMMAND=$HOME/.local/bin/powerline-config 

# add our personal bin to path
export PATH=$HOME/.bin/:$PATH

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
