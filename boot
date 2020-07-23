#!/usr/bin/env -S bash -e

set -e

if [ $CONTAINER_DEBUG ]; then
    set -x
fi

if [ $BOOT_GITREPO ]; then

    # BOOT_GITREPO path find
    cd /
    BOOT_GITREPO_PATH="${BOOT_GITREPO##*/}"
    BOOT_GITREPO_PATH="${BOOT_GITREPO_PATH%%.git}"
    BOOT_GITREPO_PATH=readlink -f $BOOT_GITREPO_PATH

    ## export BOOT_GITREPO to /etc/bashrc
    grep -qF -- "export BOOT_GITREPO=$BOOT_GITREPO" "/etc/bashrc" || echo "BOOT_GITREPO=$BOOT_GITREPO" >> "/etc/bashrc"
    grep -qF -- "export BOOT_GITREPO_PATH=$BOOT_GITREPO_PATH" "/etc/bashrc" || echo "BOOT_GITREPO_PATH=$BOOT_GITREPO_PATH" >> "/etc/bashrc"

    # remove old repo and links
    rm -rf /$BOOT_GITREPO_PATH
    if [ $CONTAINER_DEBUG ]; then
        find -L /bin/ -type l -exec echo rm broken symlink {} \;
    fi
    find -L /bin/ -type l -exec rm {} \;

    ## link all executable to /bin
    git clone $BOOT_GITREPO
    if [ $CONTAINER_DEBUG ]; then
        find /$BOOT_GITREPO_PATH/ -type f -not -path '*/\.git/*' -executable -exec echo 'link {}' \;
    fi
    find /$BOOT_GITREPO_PATH/ -type f -not -path '*/\.git/*' -executable -exec sh -c 'f={}&&ln -s {} /bin/${f##*/}' \;
fi
exec "$@"
