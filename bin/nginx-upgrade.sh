#!/bin/sh
#
# nginx-upgrade.sh - upgrade nginx to latest version on ppa:ondrej/nginx-mainline repository
#
DEBIAN_FRONTEND="noninteractive"
export DEBIAN_FRONTEND

TARGET_ISSUE=$1
NGINX=`nginx -v 2>&1 > /dev/null | grep 1.26 | wc -l`
if [ -n "$TARGET_ISSUE" -a $NGINX -eq 0 ]; then
    MATCH=`cat /etc/issue | grep "$TARGET_ISSUE" | wc -l`
    if [ $MATCH -gt 0 ]; then
        if [ ! -f /etc/apt/sources.list.d/ondrej-ubuntu-nginx-mainline-jammy.list -a ! -f /etc/apt/sources.list.d/ondrej-ubuntu-nginx-mainline-bionic.list -a ! -f /etc/apt/sources.list.d/ondrej-ubuntu-nginx-mainline-focal.list ]; then
            echo "Adding ppa:obdrej/nginx-mainline repository"
            add-apt-repository -y  ppa:ondrej/nginx-mainline
            echo "Updating"
            apt update
            echo "Upgrading"
            apt -y upgrade 
            echo "NICE!"
        else
            echo "ppa:ondrej/nginx-mainline already installed"
            exit 3
        fi
    else
        ISSUE=`cat /etc/issue | head -1`
        echo "Ubuntu version mismatch: $ISSUE != $1"
        exit 2
    fi
else
    echo "Missing argument: $0 [UBUNTU_VERSION]"
    exit 1
fi
