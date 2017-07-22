FROM alpine:3.6

MAINTAINER ruohan.chen <crhan123@gmail.com>


# Install packages
RUN apk add --update redsocks iptables dnsmasq pdnsd supervisor bash libgcrypt curl grep openssh-client
RUN rm -rf /var/cache/apk/*

RUN addgroup redsocks; adduser -S redsocks -G redsocks

# Copy configuration files...
COPY redsocks.tmpl /etc/redsocks.tmpl
COPY whitelist.txt /etc/redsocks-whitelist.txt
COPY redsocks.sh /usr/local/bin/redsocks.sh
COPY redsocks-fw.sh /usr/local/bin/redsocks-fw.sh

RUN chmod +x /usr/local/bin/*

CMD ["/usr/local/bin/redsocks.sh"]
