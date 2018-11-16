# Setup fzf
# ---------
if [[ ! "$PATH" == */home/etherealite/$XDG_BIN_HOME* ]]; then
  export PATH="$PATH:/home/etherealite/$XDG_BIN_HOME"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$XDG_CONFIG_HOME/fzf/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "$XDG_CONFIG_HOME/fzf/key-bindings.bash"

