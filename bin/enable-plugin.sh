#!/bin/sh
#
# enable-plugin.sh
#
WPCLI="/srv/adm/bin/wp-cli.phar"
SITES="/srv/adm/conf/toyota.hosts"
PLUGIN=$1
if [ -z "$PLUGIN" ]; then
    PLUGIN="autogo-akismet"
fi
for SITE in `cat $SITES`
do
    #if [ -d "/srv/sites/platform/web/app/plugins/$PLUGIN" ]; then
        echo "Activating $PLUGIN on $SITE"
        scp $WPCLI $SITE:/srv/sites/platform/web/
        ssh $SITE "chgrp deploy /srv/sites/platform/web/wp-cli.phar; chmod 640 /srv/sites/platform/web/wp-cli.phar; su - deploy -c 'cd /srv/sites/platform/web; php wp-cli.phar plugin activate $PLUGIN'; rm /srv/sites/platform/web/wp-cli.phar"
    #else
        #echo "Plugin $PLUGIN missing"
    #fi
done
