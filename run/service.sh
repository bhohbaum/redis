#!/bin/bash

../src/redis-server redis1.conf &
../src/redis-server redis2.conf &
../src/redis-server redis3.conf &
../src/redis-server redis4.conf &

# and the slaves...

../src/redis-server redis5.conf &
../src/redis-server redis6.conf &
../src/redis-server redis7.conf &
../src/redis-server redis8.conf &


