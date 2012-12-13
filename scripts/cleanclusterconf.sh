#!/bin/bash

. /root/redis-admin/cmds.sh

/root/redis-admin/mkclusterconf.sh

$CP /root/redis-admin/cluster-nodes.conf /root/redis-admin/cluster-nodes.conf.bak

for NODE in `$CAT /root/redis-admin/cluster-nodes.conf | $GREP -v fail | $AWK '{print $2}'`
do
	HOST=`$ECHO $NODE | $SED -e 's/:/ /g' | $AWK '{print $1}'`
	PORT=`$ECHO $NODE | $SED -e "s/:/ /g" | $AWK '{print $2}'`
	FILE=`/usr/local/bin/redis-cli -h $HOST -p $PORT config get cluster-config-file | $TAIL -n 1`
	PIDS=`$SSH $HOST pidof redis-server`
	log killing $PIDS
	$SSH $HOST kill $PIDS
	$SSH $HOST "cat $FILE | grep -v fail > /tmp/nodes.conf.tmp ; cp /tmp/nodes.conf.tmp $FILE"
done

for NODE in `$CAT /root/redis-admin/cluster-nodes.conf.bak | $GREP -v fail | $AWK '{print $2}'`
do
	HOST=`$ECHO $NODE | $SED -e 's/:/ /g' | $AWK '{print $1}'`
	$SSH $HOST rm -f /var/run/redis_6379.pid
	$SSH $HOST /etc/init.d/redis_6379 start
done

$RM /root/redis-admin/cluster-nodes.conf.bak

