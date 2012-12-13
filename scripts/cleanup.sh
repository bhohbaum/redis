#!/bin/bash

. /root/redis-admin/cmds.sh

for NODE in `$CAT /root/redis-admin/cluster.conf.base`
do
	log "Cleaning node: $NODE"
	IP=`$ECHO $NODE | $SED -e 's/:/ /g' | $AWK '{print $1}'`
	$SSH $IP pkill redis-se
	$SLEEP 3
	$SSH $IP rm -f /var/lib/redis/6379/*
	$SSH $IP rm -f /var/run/redis_6379.pid
done

