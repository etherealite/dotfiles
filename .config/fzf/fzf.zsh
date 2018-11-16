# Setup fzf
# ---------
if [[ ! "$PATH" == */home/etherealite/bin* ]]; then
  export PATH="$PATH:/home/etherealite/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/etherealite/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/etherealite/shell/key-bindings.zsh"

