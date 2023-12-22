#!/bin/sh
#
# Disable icinga2 and pmm
#
service icinga2 stop
service pmm-mysql-metrics-42002 stop
service pmm-linux-metrics-42000 stop
systemctl disable icinga2
systemctl disable pmm-mysql-metrics-42002.service
systemctl disable pmm-linux-metrics-42000.service

