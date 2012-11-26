#!/bin/bash

redis-cli -h 192.168.6.64 -p 6379 cluster addslots `seq 0 1023`
redis-cli -h 192.168.6.64 -p 6380 cluster addslots `seq 1024 2047`
redis-cli -h 192.168.6.64 -p 6381 cluster addslots `seq 2048 3071`
redis-cli -h 192.168.6.64 -p 6382 cluster addslots `seq 3072 4095`

redis-cli -h 192.168.6.64 -p 6379 cluster meet 192.168.6.64 6379
redis-cli -h 192.168.6.64 -p 6379 cluster meet 192.168.6.64 6380
redis-cli -h 192.168.6.64 -p 6379 cluster meet 192.168.6.64 6381
redis-cli -h 192.168.6.64 -p 6379 cluster meet 192.168.6.64 6382

redis-cli -h 192.168.6.64 -p 6380 cluster meet 192.168.6.64 6379
redis-cli -h 192.168.6.64 -p 6380 cluster meet 192.168.6.64 6380
redis-cli -h 192.168.6.64 -p 6380 cluster meet 192.168.6.64 6381
redis-cli -h 192.168.6.64 -p 6380 cluster meet 192.168.6.64 6382

redis-cli -h 192.168.6.64 -p 6381 cluster meet 192.168.6.64 6379
redis-cli -h 192.168.6.64 -p 6381 cluster meet 192.168.6.64 6380
redis-cli -h 192.168.6.64 -p 6381 cluster meet 192.168.6.64 6381
redis-cli -h 192.168.6.64 -p 6381 cluster meet 192.168.6.64 6382

redis-cli -h 192.168.6.64 -p 6382 cluster meet 192.168.6.64 6379
redis-cli -h 192.168.6.64 -p 6382 cluster meet 192.168.6.64 6380
redis-cli -h 192.168.6.64 -p 6382 cluster meet 192.168.6.64 6381
redis-cli -h 192.168.6.64 -p 6382 cluster meet 192.168.6.64 6382


# we leave the slaves to autodiscovery...

redis-cli -h 192.168.6.64 -p 6382 cluster meet 192.168.6.64 6389
redis-cli -h 192.168.6.64 -p 6382 cluster meet 192.168.6.64 6390
redis-cli -h 192.168.6.64 -p 6382 cluster meet 192.168.6.64 6391
redis-cli -h 192.168.6.64 -p 6382 cluster meet 192.168.6.64 6392

