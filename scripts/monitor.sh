#!/bin/bash

echo "###############################################################################################"

redis-cli -h 10.59.51.113 -p 6379 keys \*
redis-cli -h 10.58.222.64 -p 6379 keys \*

redis-cli -h 10.59.51.113 -p 6379 cluster nodes
redis-cli -h 10.59.51.113 -p 6379 cluster info

