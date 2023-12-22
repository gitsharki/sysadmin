#!/bin/sh
#
# dbbackup.sh - backup current database
#
STAMP=`date +'%m%d%Y-%H%M'`
DB=$1
[ ! -d /srv/backup ] && mkdir /srv/backup
[ -z "$DB" ] && DB=dealervenom
[ -n "$2" ] && STAMP="$2"
echo "Backing up schema for $DB -> /srv/backup/$DB-schema-$STAMP.sql.bz2"
mysqldump --no-data $DB | bzip2 > /srv/backup/$DB-schema-$STAMP.sql.bz2
echo "Backing up data for $DB /srv/backup/$DB-data-$STAMP.sql.bz2"
mysqldump $DB | bzip2 > /srv/backup/$DB-data-$STAMP.sql.bz2

