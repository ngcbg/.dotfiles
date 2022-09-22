# Setup fzf
# ---------
if [[ ! "$PATH" == */home/ngc/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/ngc/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/ngc/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/ngc/.fzf/shell/key-bindings.bash"
