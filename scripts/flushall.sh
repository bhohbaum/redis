#!/bin/bash


redis-cli -h 10.59.51.113 -p 6379 flushall
redis-cli -h 10.59.51.113 -p 6380 flushall
redis-cli -h 10.59.51.113 -p 6381 flushall
redis-cli -h 10.59.51.113 -p 6382 flushall

redis-cli -h 10.59.51.113 -p 6379 cluster info

