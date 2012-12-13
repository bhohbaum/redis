#!/bin/bash

./cleanup.sh
sleep 3
./start.sh
sleep 5
./stop.sh
sleep 3
./start.sh
sleep 3
./prepare-cluster.sh 

