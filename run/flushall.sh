#!/bin/bash


redis-cli -h localhost -p 6379 flushall
redis-cli -h localhost -p 6381 flushall
redis-cli -h localhost -p 6382 flushall
redis-cli -h localhost -p 6383 flushall

redis-cli -h localhost -p 6379 cluster info

