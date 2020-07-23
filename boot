#!/usr/bin/env -S bash -e

set -x
set -e

if [ $BOOT_GITREPO ]; then

    # BOOT_GITREPO path find
    cd /
    BOOT_GITREPO_PATH="${BOOT_GITREPO##*/}"
    BOOT_GITREPO_PATH="${BOOT_GITREPO_PATH%%.git}"

    ## export BOOT_GITREPO to /etc/bashrc
    grep -qF -- "export BOOT_GITREPO=$BOOT_GITREPO" "/etc/bashrc" || echo "BOOT_GITREPO=$BOOT_GITREPO" >> "/etc/bashrc"
    grep -qF -- "export BOOT_GITREPO_PATH=$BOOT_GITREPO_PATH" "/etc/bashrc" || echo "BOOT_GITREPO_PATH=$BOOT_GITREPO_PATH" >> "/etc/bashrc"

    # remove old repo and links
    rm -rf /$BOOT_GITREPO_PATH
    find /bin/ -xtype l -exec echo rm broken symlink {} \; -exec rm {} \;

    ## link all executable to /bin
    git clone $BOOT_GITREPO
    find /$BOOT_GITREPO_PATH/ -type f -not -path '*/\.git/*' -executable -exec echo 'link {}' \; -exec sh -c 'f={}&&ln -s {} /bin/${f##*/}' \;
fi
exec "$@"
