set -gx EDITOR nvim

alias v="$EDITOR"

alias m="mmake"
alias make="mmake"

alias md="mkdir -p"
alias rd="rmdir"

# for direnv
direnv hook fish | source

# for jump
status --is-interactive; and source (jump shell fish | psub)

eval (starship init fish)