#!/bin/bash

echo "step 0: flush ssdb1 & ssdb2..."
./tools/flush-all.py -H ssdb-1
./tools/flush-all.py -H ssdb-2

echo "step 1: stop ssdb2 and push 10000 keys to ssdb1..."
ssh ssdb-2 "/etc/init.d/ssdb stop"
./tools/put-keys.py -H ssdb-1 -c 10000

echo "step 3: start ssdb2 and wait 10 seconds..."
ssh ssdb-2 "/etc/init.d/ssdb start"
sleep 10

echo "step 4: get from ssdb2 ..."
./tools/get-keys.py -H ssdb-2

echo "step 5: flush ssdb1 & ssdb2..."
./tools/flush-all.py -H ssdb-1
./tools/flush-all.py -H ssdb-2

echo "step 6: stop ssdb1 and push 10000 keys to ssdb2..."
ssh ssdb-1 "/etc/init.d/ssdb stop"
./tools/put-keys.py -H ssdb-2 -c 10000

echo "step 7: start ssdb1 and wait 10 seconds..."
ssh ssdb-1 "/etc/init.d/ssdb start"
sleep 10

echo "step 8: get from ssdb1 ..."
./tools/get-keys.py -H ssdb-1
