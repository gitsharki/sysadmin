#!/bin/sh
# 
ECHO=$1
if [ -d /srv/sites/platform -a -f /srv/sites/platform/.env ]; then
    echo "=== $ECHO"
fi
