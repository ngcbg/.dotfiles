export ZSH=/usr/share/oh-my-zsh/

ZSH_THEME="tjkirch_mod"
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[command]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=magenta'
COMPLETION_WAITING_DOTS="true"

plugins=(
git
zsh-autosuggestions
zsh-interactive-cd
z
dirhistory
copyfile
copydir
sudo
)

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export LANG=en_US.UTF-8

# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

setopt GLOB_DOTS
setopt appendhistory
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zshhistory
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)               # Include hidden files.

#unsetopt SHARE_HISTORY
setopt SHARE_HISTORY

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export HISTCONTROL=ignoreboth:erasedups
export GTK_OVERLAY_SCROLLING=0

export EDITOR='vim'
export VISUAL='nano'
export BROWSER='lynx'

if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

[[ -f ~/.zshrc-personal ]] && . ~/.zshrc-personal
[ -f "$HOME/.zsh_aliasrc" ] && source "$HOME/.zsh_aliasrc"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# POwerline
powerline-daemon -q
#set fish_function_path $fish_function_path "/usr/share/powerline/bindings/zsh"
source /usr/share/powerline/bindings/zsh/powerline.zsh
#powerline

neofetch

