FROM debian:jessie
MAINTAINER Mykhailo Lieibenson <gramatron@gmail.com>

ENV JICOFO_TAG=255
ENV JICOFO_USER=focus
ENV JICOFO_HOME=/opt/jicofo
ENV HOME=$JICOFO_HOME
ENV PATH=$JICOFO_HOME/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV XMPP_DOMAIN="example.com"
ENV XMPP_SUBDOMAIN="focus"
ENV XMPP_HOST="localhost"
ENV XMPP_PORT="5347"
ENV FOCUS_SECRET = "-secret-"
ENV FOCUS_USER = "focus"
ENV FOCUS_USER_SECRET = "#secret#"
ENV FOCUS_USER_DOMAIN = "localhost"

USER root
WORKDIR $JICOFO_HOME

RUN groupadd -r $JICOFO_USER \
    && useradd -r -m \
       -g $JICOFO_USER \
       -d $JICOFO_HOME \
       $JICOFO_USER

RUN apt-get -y update \
    && apt-get -y install git \
    && apt-get -y install wget \
    && apt-get -y install default-jdk ant maven unzip

RUN git clone https://github.com/jitsi/jicofo.git focus

RUN cd focus \
    && git checkout $JICOFO_TAG \
    && wget -O lib/maven-ant-tasks-2.1.3.jar https://www-eu.apache.org/dist/maven/ant-tasks/2.1.3/binaries/maven-ant-tasks-2.1.3.jar \
    && mvn dependency:resolve \
    && ant -lib lib/maven-ant-tasks-2.1.3.jar dist.lin64 \
    && unzip dist/linux/jicofo-linux-x64-build.SVN.zip

USER $JICOFO_USER

ADD ./scripts $JICOFO_HOME/scripts
CMD ["${JICOFO_HOME}/scripts/run.sh"]
