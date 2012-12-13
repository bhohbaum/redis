#!/bin/bash

. /root/redis-admin/cmds.sh

for HOST in `$CAT /root/redis-admin/cluster.conf.base`
do
	IP=`$ECHO $HOST | $SED -e 's/:/ /g' | $AWK '{print $1}'`
	PT=`$ECHO $HOST | $SED -e 's/:/ /g' | $AWK '{print $2}'`
	$SCP /root/redis-admin/* root@$IP:/root/redis-admin/
done

