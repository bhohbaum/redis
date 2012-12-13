#!/bin/bash

redis-cli -h 10.59.51.113 -p 6379 cluster addslots `seq 0 2047`
redis-cli -h 10.58.222.64 -p 6379 cluster addslots `seq 2048 4095`

redis-cli -h 10.59.51.113 -p 6379 cluster meet 10.58.222.64 6379

# we leave the slaves to autodiscovery...

redis-cli -h 10.59.51.113 -p 6379 cluster meet 10.59.51.77 6379
redis-cli -h 10.59.51.113 -p 6379 cluster meet 10.64.106.19 6379

redis-cli -h 10.59.51.77 -p 6379 slaveof 10.59.51.113 6379
redis-cli -h 10.64.106.19 -p 6379 slaveof 10.58.222.64 6379


