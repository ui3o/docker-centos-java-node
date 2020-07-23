FROM centos:centos8
LABEL authors="ui3o.com"

RUN yum -y update
RUN curl -sL https://rpm.nodesource.com/setup_12.x | bash -
RUN yum install -y git nodejs maven java-11-openjdk java-11-openjdk-devel tree
RUN npm i -g nnr
ENV JAVA_HOME=/usr/lib/jvm/java
# set jdk11 as default java
RUN alternatives --set java java-11-openjdk.x86_64
RUN rm -f /usr/lib/jvm/java
RUN ln -s /etc/alternatives/java_sdk_11 /usr/lib/jvm/java
COPY boot /usr/bin
COPY .bashrc /root/

ENTRYPOINT ["/bin/boot"]
 