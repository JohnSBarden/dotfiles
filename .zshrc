#
# .zshrc config
#
# basic zsh/antigen, vim, golang, nvm, setup
#
if [[ -e "${HOME}/.zprofile" ]]; then
  source "${HOME}/.zprofile"
fi

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

# vim package manager
antigen bundle vundle

# 
antigen bundle wd

# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/yarn
antigen bundle yarn

# deno
antigen bundle deno

# auto suggestions
antigen bundle zsh-users/zsh-autosuggestions

# highlighting
antigen bundle zsh-users/zsh-syntax-highlighting

# aws auto completions
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/aws
antigen bundle aws

# kubernetes
antigen bundle kubectl
antigen bundle ahmetb/kubectx

# always get more efficient
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



autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit


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
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN

# rust / cargo
export PATH="$HOME/.cargo/bin:$PATH"

# add yarn to bin
export PATH=$PATH:`yarn global bin`

# configure editors
export VISUAL=vim
export EDITOR="$VISUAL"

# configure browser
# TODO - Allow to be configurable on darwin/osx?
export BROWSER="chromium-browser"

# add krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# work variables
source ~/.agisuretrack
export DEV_HOST=dev0.intellifarms.com

export CLI_CP_SSH_USER=jbarden
export PATH="$HOME/.config/yarn/global/node_modules/.bin:$PATH"
eval `keychain --eval --agents ssh /home/jbarden/.ssh/id_ed25519 >/dev/null 2>&1`
eval `keychain --eval --agents ssh /home/jbarden/.ssh/personal/id_ed25519 >/dev/null 2>&1`

## Aliases
alias gfrbm='gfo master:master && grbm'
alias flushall='cli exec redis /usr/local/bin/redis-cli FLUSHALL'
alias yys='yarn && yarn start'
alias yyb='yarn && yarn build'
alias push='yarn build && yalc push'
relog () {cli restart "$@" && cli logs --tail=100 "$@"}
uplog () {cli up "$@" && cli logs --tail=100 "$@"}
alias eod='cli down && neofetch && $HOME/.antigen/bundles/guimeira/i3lock-fancy-multimonitor/lock && systemctl suspend'
alias update='cli self-update && cli auto-update'

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

