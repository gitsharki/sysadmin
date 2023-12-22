#!/bin/sh
if [ -d /srv/sites/platform/web/app/uploads/visualcomposer-assets/assets-bundles ]; then
    chown -R www-data /srv/sites/platform/web/app/uploads/visualcomposer-assets/assets-bundles
    chgrp -R www-data /srv/sites/platform/web/app/uploads/visualcomposer-assets/assets-bundles
    chmod -R g+w /srv/sites/platform/web/app/uploads/visualcomposer-assets/assets-bundles
fi
