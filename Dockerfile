FROM debian:jessie
MAINTAINER Mykhailo Lieibenson <gramatron@gmail.com>

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

RUN groupadd -r $JICOFO_USER \
    && useradd -r -m \
       -g $JICOFO_USER \
       -d $JICOFO_HOME \
       $JICOFO_USER
RUN apt-get update \
    && apt-get -y install git \
    && apt-get -y install default-jdk ant

USER $JICOFO_USER
WORKDIR $JICOFO_HOME

RUN git clone https://github.com/jitsi/jicofo.git focus \
    && cd focus
RUN ant dist.lin64 \
    && cd dist.lin64

ADD ./scripts $EJABBERD_HOME/scripts

CMD ["${EJABBERD_HOME}/scripts/run.sh"]
