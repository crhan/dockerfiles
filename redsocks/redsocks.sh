#!/bin/bash

[[ -z $http_proxy_ip ]] && ( echo "missing http_proxy_ip" ; exit 1)
[[ -z $http_proxy_port ]] && ( echo "missing http_proxy_port" ; exit 1)
[[ -z $socks_proxy_ip ]] && ( echo "missing socks_proxy_ip" ; exit 1)
[[ -z $socks_proxy_port ]] && ( echo "missing socks_proxy_port" ; exit 1)

echo "Creating redsocks configuration file using http proxy ${http_proxy_ip}:${http_proxy_port} and socks proxy ${socks_proxy_ip}:${socks_proxy_port}..."
sed -e "s|\${http_proxy_ip}|${http_proxy_ip}|" \
    -e "s|\${http_proxy_port}|${http_proxy_port}|" \
    -e "s|\${socks_proxy_ip}|${socks_proxy_ip}|" \
    -e "s|\${socks_proxy_port}|${socks_proxy_port}|" \
    /etc/redsocks.tmpl > /tmp/redsocks.conf

echo "Generated configuration:"
cat /tmp/redsocks.conf

echo "Activating iptables rules..."
/usr/local/bin/redsocks-fw.sh start

pid=0

# SIGUSR1 handler
usr_handler() {
  echo "usr_handler"
}

# SIGTERM-handler
term_handler() {
    if [ $pid -ne 0 ]; then
        echo "Term signal catched. Shutdown redsocks and disable iptables rules..."
        kill -SIGTERM "$pid"
        wait "$pid"
        /usr/local/bin/redsocks-fw.sh stop
    fi
    exit 143; # 128 + 15 -- SIGTERM
}

# setup handlers
trap 'kill ${!}; usr_handler' SIGUSR1
trap 'kill ${!}; term_handler' SIGTERM

echo "Starting redsocks..."
/usr/bin/redsocks -c /tmp/redsocks.conf
