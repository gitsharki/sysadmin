#!/bin/sh
CPUS=`cat /proc/cpuinfo | grep processor | wc -l`
MEMORY=`cat /proc/meminfo | grep MemTotal | awk '{print $2}'`
PROCS=`ps -ef | wc -l`
PHPPARENT=`ps -ef | grep fpm | grep 7.4 | awk '{print $2}'`
PHPSIZE=`top -n 1 -b | grep fpm | grep 7.4 | awk '{print $5}' | sort | tail -1`
PHPNUM=`ps -ef | grep $PHPPARENT | grep -v grep | wc -l`
TOP=`top -n 1 -b | grep buff`
echo "CPUS: $CPUS, RAM: $MEMORY KB, PROCS: $PROCS, PHPPROCS: $PHPNUM, PHPSIZE: $PHPSIZE"
echo  "TOP: $TOP"
