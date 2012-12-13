#!/bin/bash

. /root/redis-admin/cmds.sh

/root/redis-admin/mkclusterconf.sh

# check if failed node is master

FAIL=`$GREP fail /root/redis-admin/cluster-nodes.conf | $AWK '{print $2}'`
if [ -z "$FAIL" ]
then
	log All nodes ok.
	exit 0
fi
MASTER=`$CAT /root/redis-admin/cluster.conf.base | $AWK '{print $1}' | $GREP $FAIL`
if [ -z "$MASTER" ]
then
	log $FAIL is not a master.
	exit 0
fi

# exit if cluster state ok

for HOST in `$CAT /root/redis-admin/cluster.conf.base`
do
	IP=`$ECHO $HOST | $SED -e 's/:/ /g' | $AWK '{print $1}'`
	PT=`$ECHO $HOST | $SED -e 's/:/ /g' | $AWK '{print $2}'`
	STATE=`/usr/local/bin/redis-cli -h $IP -p $PT cluster info | $GREP cluster_state:ok`
	if [ -z "$STATE" ]
	then
		log "cluster state ok not found"
	else
		log "cluster state ok"
		exit 0
	fi
done

# select slave to promote

PROM_SLAVE=`$GREP $FAIL /root/redis-admin/cluster.conf.base | $AWK '{print $2}'`
log "Slave to promote: $PROM_SLAVE"
PROM_SLAVE_HOST=`$ECHO $PROM_SLAVE | $SED -e 's/:/ /g' | $AWK '{print $1}'`
PROM_SLAVE_PORT=`$ECHO $PROM_SLAVE | $SED -e 's/:/ /g' | $AWK '{print $2}'`

# get hashslots of failed master (must be in a sequence without gaps)

SLOTS=`$GREP $MASTER /root/redis-admin/cluster-nodes.conf | $AWK '{print $8}'`
log "Slots to migrate: $SLOTS"
SLOT_START=`$ECHO $SLOTS | $SED -e 's/-/ /g' | $AWK '{print $1}'`
SLOT_END=`$ECHO $SLOTS | $SED -e 's/-/ /g' | $AWK '{print $2}'`

# assign them to corresponding slave

NODE=`/usr/local/bin/redis-cli -h $PROM_SLAVE_HOST -p $PROM_SLAVE_PORT cluster nodes | $GREP myself | $AWK '{print $1}'`
for SLOT in `seq $SLOT_START $SLOT_END`
do
	/usr/local/bin/redis-cli -h $PROM_SLAVE_HOST -p $PROM_SLAVE_PORT cluster setslot $SLOT node $NODE
done

# and make the slave master

/usr/local/bin/redis-cli -h $PROM_SLAVE_HOST -p $PROM_SLAVE_PORT slaveof no one

# we do this better by hand.
/root/redis-admin/cleanclusterconf.sh

