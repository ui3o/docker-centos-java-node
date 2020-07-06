# .bashrc

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

run()
{
    CWD_PATH=$(pwd)
    source "$@"
    cd $CWD_PATH
}
export -f run

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi