#!/bin/sh
#
# http2-enable.sh - enables http2 on nginx servers for ssl port 443
#
WHOAMI=`whoami`
PWD=`pwd`
if [ "$WHOAMI" != "root" ]; then
    echo "$0 must be run as root"
    exit 1
fi
if [ ! -d /etc/nginx/conf.d ]; then
    echo "$0 requires nginx"
    exit 2
fi

cd /etc/nginx/conf.d
for CONFIG in `ls *conf`
do
    TMP=`mktemp`
    if [ -f $TMP ]; then
        cat $CONFIG | sed 's/listen 443 ssl;$/listen 443 ssl; http2 on;/' > $TMP
        cp $CONFIG $CONFIG.before_http2
        cp $TMP $CONFIG
        chmod 644 $CONFIG
        rm -f $TMP
    fi
done    
cd $PWD
