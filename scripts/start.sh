#!/bin/bash

. /root/redis-admin/cmds.sh

for NODE in `$CAT /root/redis-admin/cluster.conf.base`
do
	HOST=`$ECHO $NODE | $SED -e 's/:/ /g' | $AWK '{print $1}'`
	$SSH $HOST "rm -f /var/run/redis_6379.pid ; /etc/init.d/redis_6379 start"
done


