# docker-centos-java-node

Docker image with:

* git
* openjdk11
* nodejs12


# Feature

* $BOOT_GITREPO, add repository url to clone external script before boot
* every shebang `#!/usr/bin/env -S bash -l` can access $BOOT_GITREPO environment variable
