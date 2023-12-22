#!/bin/sh
#
# dbbackup.sh - backup current database
#
TABLES='wp_options wp_posts'
STAMP=`date +'%m%d%Y-%H%M'`
DB=$1
[ ! -d /srv/backup ] && mkdir /srv/backup
[ -z "$DB" ] && DB=dealervenom
[ -n "$2" ] && STAMP="$2"
#echo "Backing up schema for $DB -> /srv/backup/$DB-schema-$STAMP.sql.bz2"
#mysqldump --no-data $DB | bzip2 > /srv/backup/$DB-schema-$STAMP.sql.bz2
echo "Backing up tables $TABLES for $DB /srv/backup/$DB-tables-$STAMP.sql.bz2"
mysqldump $DB $TABLES | bzip2 > /srv/backup/$DB-tables-$STAMP.sql.bz2

