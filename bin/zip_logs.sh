#!/bin/sh
#
# zip_logs.sh - create a bzipped tar ball of all web logs
# 
if [ -z "$1" ]; then
    NAME="logs"
else
    NAME="$1"
fi

LOGDIR="/var/log/nginx"
ACCESS="access.log"
ERROR="error.log"
DIR=`mktemp -d`
mkdir -p $DIR/$NAME
cp $LOGDIR/"$ACCESS"* $DIR/$NAME
cp $LOGDIR/"$ERROR"* $DIR/$NAME
cd $DIR
tar cvfj $NAME.tar.bz2 $NAME
#echo $DIR/$NAME.tar.bz2
mv $NAME.tar.bz2 /tmp/nginx-logs.tar.bz2
cd /tmp
rm -rf $DIR
