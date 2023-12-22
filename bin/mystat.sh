#!/bin/sh
#
# mystats.sh - mysql stats
#
HOST=$1
head -1 /etc/issue
uname -a
VLM=`du -sh /var/lib/mysql | awk '{print $1}'`
if [ -f /var/lib/mysql/binlog.index ]; then
    NBL=`ls -la /var/lib/mysql/binlog* | wc -l`
    BFF=`ls -la /var/lib/mysql/binlog* | head -1`
    BLF=`ls -la /var/lib/mysql/binlog* | grep -v index | tail -1`
    echo "purge binary logs before '2023-11-01';" | mysql
else
    NBL=""
    BFF=""
    BLF=""
fi
echo "$VLM,$HOST,$NBL,$BFF,$BLF"
