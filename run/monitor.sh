#!/bin/bash

echo "###############################################################################################"

redis-cli -h localhost -p 6379 keys \*
redis-cli -h localhost -p 6380 keys \*
redis-cli -h localhost -p 6381 keys \*
redis-cli -h localhost -p 6382 keys \*

redis-cli -h localhost -p 6379 cluster info

