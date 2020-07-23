# .bashrc

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# script start alias
sstart()
{
    CWD_PATH=$(readlink -f $(pwd))
    eval $@
    cd $CWD_PATH
}

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi