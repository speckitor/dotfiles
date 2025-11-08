[[ $- != *i* ]] && return

alias vim=nvim
alias ls='ls -C --color=auto -hr'
alias grep='grep --color=auto'
alias date='date -R'

PS1='[\[\e[0;31m\]\u\[\e[0;0m\]@\h \[\e[0;32m\]\W\[\e[0;0m\]] $ '
