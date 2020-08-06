# docker-centos-java-node

Docker image with:

* git
* openjdk11
* nodejs12


# Feature

* $BOOT_GITREPO, add repository url to clone external script before boot
* **default openjdk** version is **11**
* $JAVA_VERSION=[8|11], possible to set openjdk version before boot, example: $JAVA_VERSION=8 or $JAVA_VERSION=11
* set $CONTAINER_DEBUG=true, to debug boot section
* **run** alias for execute script with source command
