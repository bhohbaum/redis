#!/bin/bash

echo "###############################################################################################"

redis-cli -h 192.168.6.64 -p 6379 keys \*
redis-cli -h 192.168.6.64 -p 6380 keys \*
redis-cli -h 192.168.6.64 -p 6381 keys \*
redis-cli -h 192.168.6.64 -p 6382 keys \*

redis-cli -h 192.168.6.64 -p 6379 cluster info

