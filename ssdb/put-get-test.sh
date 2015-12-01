#!/bin/bash

echo "step 1: push to ssdb1 and get from ssdb2..."
./tools/flush-all.py -H ssdb-1
./tools/flush-all.py -H ssdb-2
./tools/put-get.sh ssdb-1 ssdb-2 10000

echo "step 2: push to ssdb2 and get from ssdb1..."
./tools/flush-all.py -H ssdb-1
./tools/flush-all.py -H ssdb-2
./tools/put-get.sh ssdb-2 ssdb-1 10000
