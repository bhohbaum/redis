#!/bin/bash

. /root/redis-admin/cmds.sh

#/root/redis-admin/mkclusterconf.sh

for NODE in `$CAT /root/redis-admin/cluster.conf.base | $AWK '{print $2}'`
do
	HOST=`$ECHO $NODE | $SED -e 's/:/ /g' | $AWK '{print $1}'`
	PORT=`$ECHO $NODE | $SED -e 's/:/ /g' | $AWK '{print $2}'`
	MASTER=`$CAT /root/redis-admin/cluster.conf.base | $GREP $NODE | $AWK '{print $1}'`
	MASTER_HOST=`$ECHO $MASTER | $SED -e 's/:/ /g' | $AWK '{print $1}'`
	MASTER_PORT=`$ECHO $MASTER | $SED -e 's/:/ /g' | $AWK '{print $2}'`
	MS=`/usr/local/bin/redis-cli -h $HOST -p $PORT config get slaveof | $TAIL -n 1 | $SED -e 's/ /:/g'`
	if [ -z $MS ]
	then
		echo "This node is a master: $NODE"
	else
		/usr/local/bin/redis-cli -h $HOST -p $PORT slaveof no one
		/usr/local/bin/redis-cli -h $HOST -p $PORT slaveof $MASTER_HOST $MASTER_PORT
	fi
done

