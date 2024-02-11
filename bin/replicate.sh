#!/bin/sh
#
# replicate.sh - script to replicate database and platform code from give host
#

TARGET=$1
ACTION=$2

ping -c1 -w1 $TARGET
if [ $? -eq 1 ]; then
    echo "Unable to ping $TARGET, giving up"
    exit 1
fi

# dump and load database
rm -f /tmp/$TARGET.sql.bz2
echo "Dumping dealervenom@$TARGET database to /tmp/$TARGET.sql.bz2"
mysqldump -h $TARGET dealervenom | bzip2 > /tmp/$TARGET.sql.bz2
if [ -f /tmp/$TARGET.sql.bz2 ]; then
    echo "Restoring dump to replica@localhost "
    bzcat /tmp/$TARGET.sql.bz2 | mysql replica
else
    echo "Dump failed, quitting"
    exit 1
fi

if [ -z "$ACTION" ]; then
    echo "Syncing platform content, log: /tmp/$TARGET.rsync.log"
    rsync -av --exclude=.env --exclude=.git/ --exclude=web/app/cache/ --delete replica@$TARGET:/srv/sites/platform/ /srv/sites/replica.dealervenom.com/ > /tmp/$TARGET.rsync.log 2>&1
    chgrp -R www-data /srv/sites/replica.dealervenom.com
    chmod -R g+w /srv/sites/replica.dealervenom.com

    echo "Copying keys and salts"
    scp -q replica@$TARGET:/srv/sites/platform/.env /tmp/.$TARGET.env
    cat /tmp/.$TARGET.env | egrep "SALT|KEY|WP_ENV" > /tmp/.$TARGET.env.os
    cat /srv/sites/replica.dealervenom.com/.env | egrep -v "SALT|KEY|WP_ENV" > /tmp/.$TARGET.env.ns
    cat /tmp/.$TARGET.env.os >> /tmp/.$TARGET.env.ns
    mv /tmp/.$TARGET.env.ns /srv/sites/replica.dealervenom.com/.env
    rm -f /tmp/.$TARGET.env*
fi

echo "Done deal!"

