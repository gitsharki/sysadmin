#!/bin/sh
#
# nginx-http2.sh - enable http2 on ssl nginx servers
#
CWD=`pwd`
if [ ! -d /etc/nginx/conf.d ]; then
    echo "Missing /etc/nginx/conf.d"
    exit 1
fi

mkdir -p /srv/backup
DATE=`date +'%m%d%Y'`

if [ ! -f /srv/backup/$DATE-nginx.tar.bz2 ]; then
    cd /etc
    tar cvfj /srv/backup/$DATE-nginx.tar.bz2 nginx
    cd /etc/nginx/conf.d
fi

for FILE in `grep "listen 443 ssl" *conf | grep -v http2 | awk -F: '{print $1}'`
do
    echo "Enabling HTTP2 on $FILE"
    if [ ! -f $FILE.before_http2 ]; then
        cp $FILE $FILE.before_http2
    fi
    TEMP=`mktemp`
    cat $FILE |  sed 's/listen 443 ssl;$/listen 443 ssl; http2 on;/' > $TEMP
    diff $TEMP $FILE
    cp $TEMP $FILE
    rm $TEMP
done
cd $CWD
nginx -t
