#!/bin/sh
#
# lssys.sh - script to print system information
#
hostnamectl | grep Static
timedatectl | egrep "Local|zone"
uname -a
cat /etc/issue | head -1
echo 'select @@version' | mysql | grep -v version
lscpu | grep CPU\(s\): | head -1
free -m
df -h | grep vda
