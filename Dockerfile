FROM debian:jessie
MAINTAINER Mykhailo Lieibenson <gramatron@gmail.com>

ENV JICOFO_USER=focus \
    JICOFO_HOME=/opt/jicofo \
    HOME=$JICOFO_HOME \
    PATH=$JICOFO_HOME/bin:/usr/sbin:/usr/bin:/sbin:/bin \
    XMPP_DOMAIN="example.com" \
    XMPP_SUBDOMAIN="focus" \
    XMPP_HOST="localhost" \
    XMPP_PORT="5347" \
    FOCUS_SECRET = "-secret-" \
    FOCUS_USER = "focus" \
    FOCUS_USER_SECRET = "#secret#" \
    FOCUS_USER_DOMAIN = "localhost"

RUN groupadd -r $JICOFO_USER \
    && useradd -r -m \
       -g $JICOFO_USER \
       -d $JICOFO_HOME \
       $JICOFO_USER

USER root
RUN apt-get install default-jdk ant

USER $JICOFO_USER
WORKDIR $JICOFO_HOME

RUN git clone https://github.com/jitsi/jicofo.git focus \
    cd focus
RUN ant dist.lin64 \
    cd dist.lin64

ADD ./scripts $EJABBERD_HOME/scripts

CMD ["${EJABBERD_HOME}/scripts/run.sh"]
