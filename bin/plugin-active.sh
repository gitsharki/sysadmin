#!/bin/sh
#
# plugin-active.sh - checks if plugin is active in given database
#
DBS="dealervenom staging"
[ -n "$2" ] && DBS="$2"
PLUGIN=$1
if [ -z "$PLUGIN" ]; then
    echo "Searches databases: $DBS for active wordpress plugin specified"
    echo "Usage $0 plugin"
    echo "or $0 plugin database"
    exit 1
fi
for DB in $DBS
do
    #echo "Checking $DB for $PLUGIN"
    ACTIVE=`mysql dealervenom -ss --raw -N -e 'SELECT option_value FROM wp_options WHERE option_name="active_plugins"' | php -r "var_dump(unserialize(stream_get_contents(STDIN)));" | grep $PLUGIN | grep string | awk '{print $2}' | wc -l`
    #echo "RESULT: $ACTIVE"
    echo "Database $DB: ,Plugin: $PLUGIN, ACTIVE: $ACTIVE"
done
