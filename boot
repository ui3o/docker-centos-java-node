#!/usr/bin/env -S bash

if [ $BOOT_GITREPO ]; then
    ## export BOOT_GITREPO to /etc/bashrc
    grep -qF -- "export BOOT_GITREPO=$BOOT_GITREPO" "/etc/bashrc" || echo "BOOT_GITREPO=$BOOT_GITREPO" >> "/etc/bashrc"
    
    ## link all executable to /bin/
    cd / && \
    git clone $BOOT_GITREPO && \
    REPO_ROOT="${BOOT_GITREPO##*/}" && \
    REPO_ROOT="${REPO_ROOT%%.git}" && \
    find /$REPO_ROOT -type f -executable -exec sh -c 'f={}&&ln -s {} /bin/${f##*/}' \;
fi
