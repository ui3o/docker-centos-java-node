FROM centos:centos8
LABEL authors="ui3o.com"

RUN yum -y update
RUN curl -sL https://rpm.nodesource.com/setup_12.x | bash -
RUN yum install -y git nodejs maven java-11-openjdk java-11-openjdk-devel
RUN npm i -g nnr
ENV JAVA_HOME=/usr/lib/jvm/java
RUN rm -rf /etc/alternatives/ /usr/lib/jvm/java
RUN ln -s /usr/lib/jvm/java-11-openjdk-11.0.7.10-1.el8_1.x86_64/ /usr/lib/jvm/java
ENV PATH="$PATH:/usr/lib/jvm/java/bin/:/usr/share/maven/bin/"
COPY boot /usr/bin

ENTRYPOINT ["/bin/boot"]
 