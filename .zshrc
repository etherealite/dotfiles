# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob nomatch notify
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install

source ~/.local/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle command-not-found
antigen bundle autojump
antigen bundle common-aliases
antigen bundle compleat
antigen bundle git-extras
antigen bundle npm
antigen bundle web-search
antigen bundle z
antigen bundle zsh-users/zsh-syntax-highlighting
#antigen bundle zsh-users/zsh-history-substring-search ./zsh-history-substring-search.zsh

# Load the theme.
antigen theme gnzh

# Tell antigen that you're done.
antigen apply

# Setup zsh-autosuggestions
source ~/.local/zsh-autosuggestions/zsh-autosuggestions.zsh

# Enable autosuggestions automatically
 # zle-line-init() {
     # zle autosuggest-start
 # }

# zle -N zle-line-init