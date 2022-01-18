FROM centos:centos8
LABEL authors="ui3o.com"

RUN yum -y update
RUN curl -sL https://rpm.nodesource.com/setup_12.x | bash -
RUN yum install -y wget git nodejs java-1.8.0-openjdk java-1.8.0-openjdk-devel java-11-openjdk java-11-openjdk-devel tree
RUN npm i -g nnr

# set jdk11 as default java
ENV JAVA_HOME=/usr/lib/jvm/java
RUN alternatives --set java java-11-openjdk.x86_64
RUN rm -f /usr/lib/jvm/java
RUN ln -s /etc/alternatives/java_sdk_11 /usr/lib/jvm/java

# maven-3.6.3 install
RUN wget https://downloads.apache.org/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz -P /tmp
RUN tar xf /tmp/apache-maven-3.6.3-bin.tar.gz -C /opt
RUN ln -s /opt/apache-maven-3.6.3 /opt/maven
ENV M2_HOME=/opt/maven
ENV MAVEN_HOME=/opt/maven
ENV PATH=${M2_HOME}/bin:${PATH}


# install gitlab-release-note-generator
RUN git clone https://github.com/ui3o/gitlab-release-note-generator.git /opt/gitlab-release-note-generator && cd /opt/gitlab-release-note-generator &&  npm i

COPY boot /usr/bin
COPY .bashrc /root/

ENTRYPOINT ["/bin/boot"]
 