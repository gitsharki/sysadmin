#!/bin/sh
#
# Run a report on toyota mystery shopper forms
#
if [ -f /srv/sites/platform/web/app/plugins/autogo-akismet/data/emails ]; then
    EMAILS=`cat /srv/sites/platform/web/app/plugins/autogo-akismet/data/emails  | awk '{print ","$1","}' | tr ',' "'" | tr '\n' ',' | sed s/,$//`
    echo "SELECT wp_gf_form.title, wp_gf_entry.ip, wp_gf_entry.date_created, wp_gf_entry.status, wp_gf_entry_meta.meta_key, wp_gf_entry_meta.meta_value as email FROM  wp_gf_form JOIN wp_gf_entry ON wp_gf_form.id = wp_gf_entry.form_id JOIN wp_gf_entry_meta ON wp_gf_entry.id = wp_gf_entry_meta.entry_id WHERE wp_gf_entry_meta.meta_value IN ( $EMAILS );"  | mysql dealervenom
else 
    echo "Missing akismet whitelist: /srv/sites/platform/web/app/plugins/autogo-akismet/data/emails"
fi
