[[ $- != *i* ]] && return

function ts () {
    if [ "$TERM_PROGRAM" == "tmux" ]; then
        tmux detach -E 'dir="$(
            find ~/ ~/programming/ ~/programming/probe/ -maxdepth 1 -type d |
            fzf |
            xargs realpath
        )" && tmux new -A -c "$dir" -s "$dir"'
    else
        dir="$(
            find ~/ ~/programming/ ~/programming/probe/ -maxdepth 1 -type d |
            fzf |
            xargs realpath
        )" && tmux new -A -c "$dir" -s "$dir"
    fi
}

alias ls='ls -C --color=auto -hr'
alias grep='grep --color=auto'
alias date='date -R'

PS1='[\[\e[0;31m\]\u\[\e[0;0m\]@\h \[\e[0;32m\]\W\[\e[0;0m\]] $ '
. "$HOME/.cargo/env"
