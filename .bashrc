# .bashrc

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# script run alias
run()
{
    if [ $CONTAINER_DEBUG ]; then
        set -x
    fi
    CWD_PATH=$(readlink -f $(pwd))
    eval $@
    cd $CWD_PATH
    if [ $CONTAINER_DEBUG ]; then
        set +x
    fi
}

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi