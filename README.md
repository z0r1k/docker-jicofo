## Run arguments descripton

* ```--domain=DOMAIN``` sets the XMPP domain
* ```--host=HOST``` sets the hostname of the XMPP server (default: --domain, if --domain is set, localhost otherwise)
* ```--port=PORT``` sets the port of the XMPP server (default: 5347)
* ```--subdomain=SUBDOMAIN``` sets the sub-domain used to bind focus XMPP component (default: focus)
* ```--secret=SECRET``` sets the shared secret used to authenticate focus component to the XMPP server
* ```--user_domain=DOMAIN``` specifies the name of XMPP domain used by the focus user to login
* ```--user_name=USERNAME``` specifies the username used by the focus XMPP user to login. (default: focus@user_domain)
* ```--user_password=PASSWORD``` specifies the password used by focus XMPP user to login. If not provided then focus user will use anonymous authentication method

More information about **JItsi COnference FOcus** could be found here: [https://github.com/jitsi/jicofo](https://github.com/jitsi/jicofo)