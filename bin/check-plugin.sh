#!/bin/sh
#
# Checks plugin version
#
FILE="/srv/sites/platform/web/app/plugins/$1/$1.php"
if [ -f $FILE ]; then
    VERSION=`grep Version $FILE | awk '{print $3}'`
    echo "$1 : $VERSION"
fi
