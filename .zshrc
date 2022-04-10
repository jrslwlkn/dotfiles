export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
export HISTFILE=~/.zsh_history
setopt INC_APPEND_HISTORY
export HISTTIMEFORMAT="[%F %T] "
setopt EXTENDED_HISTORY
setopt HIST_FIND_NO_DUPS
#setopt HIST_IGNORE_ALL_DUPS
setopt histignoredups

bindkey -v

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
autoload -Uz compinit && compinit

# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats 'on %b'
 
# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
PROMPT='%n in ${PWD/#$HOME/~} ${vcs_info_msg_0_} $ '
