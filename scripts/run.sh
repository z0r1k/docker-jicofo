#!/bin/bash

exec jicofo.sh \
    --domain=$XMPP_DOMAIN \
    --subdomain=$XMPP_SUBDOMAIN \
    --host=$XMPP_HOST \
    --port=$XMPP_PORT \
    --secret=$FOCUS_SECRET \
    --user_domain=$FOCUS_USER_DOMAIN \
    --user_name=$FOCUS_USER \
    --user_password=$FOCUS_USER_SECRET
