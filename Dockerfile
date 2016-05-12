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
    && apt-get -y install default-jdk maven

RUN git clone https://github.com/jitsi/jicofo.git focus

RUN cd focus \
    && git checkout $JICOFO_TAG \
    && mvn -U clean package -DskipTests

RUN cp -R focus/lib focus/target/ \
    && focus/resources/install/linux-64/jicofo.sh focus/target/ \
    && chmod +x focus/target/jicofo.sh

USER $JICOFO_USER

ADD ./scripts $EJABBERD_HOME/scripts
CMD ["${EJABBERD_HOME}/scripts/run.sh"]
