# Prompt (also for non-login shells: tmux, ssh commands, nested bash)
[ -f "$HOME/dotfiles/bash/dots/prompt" ] && source "$HOME/dotfiles/bash/dots/prompt"


# Optional: Load custom aliases
[ -f "$HOME/dotfiles/bash/dots/aliases" ] && source "$HOME/dotfiles/bash/dots/aliases"

# Optional: Load custom functions
[ -f "$HOME/dotfiles/bash/dots/functions" ] && source "$HOME/dotfiles/bash/dots/functions"

# opencode
export PATH=/Users/bobbymatson/.opencode/bin:$PATH
