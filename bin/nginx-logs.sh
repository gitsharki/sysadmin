#!/bin/sh
#
#  web_logs.sh - gather web server logs from all available droplets
# 
HOSTS="/srv/adm/conf/zabbix.hosts"
STAMP=`date +'%m%d%Y'`
mkdir -p /srv/backup/nginx-logs-$STAMP
for HOST in `cat $HOSTS | grep -v ^#`
do
    echo "====== $HOST ======="
    echo "Gathering nginx logs on $HOST"
    scp /srv/adm/bin/zip_logs.sh $HOST:/tmp/
    ssh $HOST "/tmp/zip_logs.sh $HOST"
    scp $HOST:/tmp/nginx-logs.tar.bz2 /srv/backup/nginx-logs-$STAMP/$HOST-nginx.logs.tar.bz2
    ssh $HOST "rm /tmp/zip_logs.sh; rm /tmp/nginx-logs.tar.bz2"
done

