# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific aliases and functions

alias mc="mc -b"
alias ls="ls --color=always"
alias less="less -R"
alias yum='yum -C'
alias tmux="TERM=screen-256color tmux"
