#!/bin/sh
#
# disable-binlog.sh - Disables and cleans up binlogs on a given server
#
cat /etc/issue | head -1
echo "select @@version" | mysql | grep -v version
uname -a
df -h / | grep -v Files
if [ -f /var/lib/mysql/binlog.index ]; then
    if [ -d /etc/mysql/mysql.conf.d -a ! -f /etc/mysql/mysql.conf.d/disable-binlog.cnf ]; then
        echo "[mysqld]" > /etc/mysql/mysql.conf.d/disable-binlog.cnf
        echo "skip-log-bin" >> /etc/mysql/mysql.conf.d/disable-binlog.cnf
        service mysql restart
        #mkdir /var/lib/mysql/binlogs
        #mv /var/lib/mysql/binlog* /var/lib/mysql/binlogs
    fi
fi
