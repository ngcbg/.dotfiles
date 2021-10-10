[[ $- != *i* ]] && return
[[ $- == *i* ]] && stty -ixon

# Various config files {{{

[[ -f /etc/bash_completion ]] && . /etc/bash_completion
[[ -f /etc/profile ]] && . /etc/profile
[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases
[[ -f ~/.fzf.bash ]] && . ~/.fzf.bash

#if [ -f ~/.bash_aliases ]; then
    #. ~/.bash_aliases
#fi

#}}}

# Define Colors {{{
red='\[\e[0;31m\]'
RED='\e[1;31m'
blue='\e[0;34m'
BLUE='\e[1;34m'
cyan='\e[0;36m'
CYAN='\e[1;36m'
NC='\e[0m' # No Color
black='\e[0;30m'
BLACK='\e[1;30m'
green='\e[0;32m'
GREEN='\e[1;32m'
yellow='\e[0;33m'
YELLOW='\e[1;33m'
magenta='\e[0;35m'
MAGENTA='\\e[1;35m'
white='\e[0;37m'
WHITE='\e[1;37m'
# }}}

# Some one-liners: have(), lsd() {{{
have() { type "$1" &> /dev/null; }
function lsd(){ ls -l "$@"| egrep "^d" ; ls -lXB "$@" 2>&-| egrep -v "^d|total "; }
# }}}

# fstr() -- Find string in files {{{
function fstr()
{
 OPTIND=1
 local case=""
 local usage="fstr: find string in files."
 #Usage: fstr [-i] \"pattern\" [\"filename pattern\"] "
	while getopts :it opt
	do
		case "$opt" in
			i) case="-i " ;;
			*) echo "$usage"; return;;
		esac
	done
 shift $(( $OPTIND - 1 ))
	if [ "$#" -lt 1 ]; then
		echo "$usage"
		return;
	fi
 local SMSO=$(tput smso)
 local RMSO=$(tput rmso)
 find . -type f -name "${2:-*}" -print0 | xargs -0 grep -sn ${case} "$1" 2>&- | sed "s/$1/${SMSO}\0${RMSO}/gI" | more
 
}
# }}}

# swap() -- switch 2 filenames around {{{
function swap()
{
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}
# }}}

# ni() -- networking information {{{
function ni() # get current host related info
{
echo -e "\nYou are logged on ${RED}$HOST"
    echo -e "\nAdditionnal information:$NC " ; uname -a
    echo -e "\n${RED}Users logged on:$NC " ; w -h
    echo -e "\n${RED}Current date :$NC " ; date
    echo -e "\n${RED}Machine stats :$NC " ; uptime
    echo -e "\n${RED}Memory stats :$NC " ; free -m
    MY_IP=$(/sbin/ifconfig enp8s0 | awk '/inet/ { print $2 } ' | sed -e s/addr://)
    MY_IP_WIFI=$(/sbin/ifconfig wlan0 | awk '/inet/ { print $2 } ' | sed -e s/addr://)
    echo -e "\n${RED}Local IP Address :$NC" ; echo ${MY_IP:-"Not connected"}
    echo -e "\n${RED}Local IP Address (Wireless) :$NC" ; echo ${MY_IP_WIFI:-"Not connected"}
    echo
}
# }}}

# repeat() -- repeat a given command N times {{{
function repeat() # repeat n times command
{
    local i max
    max=$1; shift;
    for ((i=1; i <= max ; i++)); do
eval "$@";
    done
}
# }}}

# ask() -- ask user a yes/no question {{{
function ask()
{
    echo -n "$@" '[y/N] ' ; read ans
    case "$ans" in
        y*|Y*) return 0 ;;
        *) return 1 ;;
    esac
}
# }}}

# {{{
# search through directory contents with grep'
function lsgrep() {
	ls | grep "$@"
}
# }}}

# {{{

# # ex = EXtractor for all kinds of archives
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   tar xf $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# }}}

# rot13() {{{
rot13 () { 
    if [ $# -eq 0 ]; then
tr '[a-m][n-z][A-M][N-Z]' '[n-z][a-m][N-Z][A-M]'
    else
echo $* | tr '[a-m][n-z][A-M][N-Z]' '[n-z][a-m][N-Z][A-M]'
    fi
}
# }}}

# Un-rot13 {{{
unrot13 () {
	if [ $# -eq 0 ]; then
tr 'N-ZA-Mn-za-m5-90-4' 'A-Za-z0-9'
	else
echo $* | tr 'N-ZA-Mn-za-m5-90-4' 'A-Za-z0-9'
	fi
}
# }}}

# isprime() -- Is $1 prime? {{{
isprime () {
    perl -wle 'print "Prime" if (1 x shift) !~ /^1?$|^(11+?)\1+$/'
#.~/.isprime
}
# }}}

export HISTCONTROL=ignoreboth:erasedups
export GTK_OVERLAY_SCROLLING=0
export EDITOR='vim'
export VISUAL='nano'
export BROWSER='lynx'

PS1='[\u@\h \W]\$ '

if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

if [ -t 1 ]; then
    bind "set completion-ignore-case on"
    bind "TAB:menu-complete"
    bind "set show-all-if-ambiguous on"
    bind "set menu-complete-display-prefix on"
    bind '""\e[Z":menu-complete-backward'
fi

# Set some bash options {{{
set -o notify
shopt -s checkhash
shopt -s checkwinsize
shopt -s sourcepath
shopt -s no_empty_cmd_completion
shopt -s cmdhist
shopt -s autocd # change to named directory
shopt -s cdspell # autocorrects cd misspellings
shopt -s cmdhist # save multi-line commands in history as single line
shopt -s dotglob
shopt -s nocaseglob
shopt -s globstar
shopt -s histappend histreedit histverify # do not overwrite history
export HISTFILESIZE=500000
export HISTSIZE=100000
export HISTIGNORE='&:cd:ls:bin/ss;history *'
bind '"\e[B": history-search-forward'
bind '"\e[A": history-search-backward'
export HISTCONTROL='ignoreboth'
shopt -s expand_aliases # expand aliases
# }}}

# Powerline
powerline-daemon -q
source /usr/share/powerline/bindings/bash/powerline.sh

#neofetch
ufetch

