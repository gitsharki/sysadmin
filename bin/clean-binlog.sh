#!/bin/sh
# 
# clean-binlog.sh - remove binlogs if they're disabled
#
if [ -f /etc/mysql/mysql.conf.d/disable-binlog.cnf ]; then
    if [ -f /var/lib/mysql/binlog.index ]; then
        df -h /
        rm /var/lib/mysql/binlog.* 
        df -h / | grep -v Files
    fi
fi

