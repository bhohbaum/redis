#!/bin/bash

. /root/redis-admin/cmds.sh

log "#######################################################"

for NODE in `$CAT /root/redis-admin/cluster.conf.base`
do
	log $NODE
	HOST=`$ECHO $NODE | $SED -e 's/:/ /g' | $AWK '{print $1}'`
	PORT=`$ECHO $NODE | $SED -e "s/:/ /g" | $AWK '{print $2}'`
	/usr/local/bin/redis-cli -h $HOST -p $PORT cluster nodes > /root/redis-admin/cluster-nodes.conf
done

> /root/redis-admin/cluster.conf

log "-------------------------------------------------------"


for NODE in `$CAT /root/redis-admin/cluster-nodes.conf | $GREP -v fail | $AWK '{print $2}'`
do
	HOST=`$ECHO $NODE | $SED -e 's/:/ /g' | $AWK '{print $1}'`
	PORT=`$ECHO $NODE | $SED -e "s/:/ /g" | $AWK '{print $2}'`
	MASTER=`/usr/local/bin/redis-cli -h $HOST -p $PORT config get slaveof | $TAIL -n 1 | $SED -e 's/ /:/g'`
	if [ -z "$MASTER" ]
	then
		log $NODE has no master
	else
		log $MASTER $NODE >> /root/redis-admin/cluster.conf
	fi
done

