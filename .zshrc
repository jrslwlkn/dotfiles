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
PROMPT='%F{magenta}${PWD/#$HOME/~} %F{green}${vcs_info_msg_0_} %F{yellow}$%F{reset_color} '

# opam configuration
[[ ! -r /Users/yareque/.opam/opam-init/init.zsh ]] || source /Users/yareque/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

if type rg &> /dev/null; then
	export FZF_DEFAULT_COMMAND='rg --files'
	export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi

alias vi="nvim"

alias gs="git status"
alias gl="git log"
alias gap="git add -p"
alias gc="git commit"
alias gca="git commit --amend"
alias gcan="git commit --amend --no-edit"

