autoload -U colors && colors
PS1="%{$fg[green]%}%1~ %{$reset_color%}$%b "
source <(fzf --zsh)

mkcd() {
    mkdir -p "$1" && cd "$1"
}

bindkey -s ^f "tmux-sessionizer\n"

alias vim=nvim
alias vi=nvim
alias ls='ls -C -h --color=auto'
alias grep='grep --color=auto'
alias date='date -R'
