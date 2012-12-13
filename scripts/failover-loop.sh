#!/bin/bash

. /root/redis-admin/cmds.sh

COUNT=`$PS -ef | $GREP failover-loop.sh | $GREP -v grep | $AWK '{print $2}' | wc -l`

log count: $COUNT

if [ "$COUNT" = "3" ]
then
	while [ true ]
	do
		/root/redis-admin/failover.sh
		sleep 1
	done
else
	log "failover-loop.sh already running..."
fi
