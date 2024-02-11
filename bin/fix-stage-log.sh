#!/bin/sh
#
# fix-stage-log.sh - fix nginx logfile name for staging configs
#
CWD=`pwd`
[ ! -d /etc/nginx/conf.d ] && exit 1
cd /etc/nginx/conf.d
for CONF in `ls *stage*.conf`
do
    COUNT=`cat $CONF | grep "\/access.log" | wc -l`
    if [ $COUNT -gt 0 ]; then
        cat $CONF | sed -E -e "s/\/(access|error)\.log/\/staging-\1.log/" > /tmp/$CONF
        mv $CONF $CONF.bak
        mv /tmp/$CONF $CONF
        chmod 644 $CONF
        service nginx restart
    fi
done
cd $CWD
