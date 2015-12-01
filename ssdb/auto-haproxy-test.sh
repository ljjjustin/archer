#!/bin/bash

echo "step 0: flush ssdb1 & ssdb2..."
./tools/flush-all.py -H ssdb-1
./tools/flush-all.py -H ssdb-2

echo "step 1: push 10000 keys to ssdb..."
./tools/put-keys.py -H haproxy-1 -c 10000

echo "step 2: get 10000 keys from ssdb..."
./tools/get-keys.py -H haproxy-1

echo "step 3: stop ssdb-1 and wait 10 seconds..."
ssh ssdb-1 "/etc/init.d/ssdb stop"
sleep 10

echo "step 4: get 10000 keys from ssdb ..."
./tools/get-keys.py -H haproxy-1

echo "step 5: start ssdb-1 and wait 10 seconds..."
ssh ssdb-1 "/etc/init.d/ssdb start"
sleep 10

echo "step 6: stop ssdb-2 and wait 10 seconds..."
ssh ssdb-2 "/etc/init.d/ssdb stop"
sleep 10

echo "step 7: get 10000 keys from ssdb ..."
./tools/get-keys.py -H haproxy-1

echo "step 8: push 10000 keys to ssdb again..."
./tools/put-keys.py -H haproxy-1 -c 10000

echo "step 9: get 20000 keys from ssdb..."
./tools/get-keys.py -H haproxy-1

echo "step 10: start ssdb-2 and wait 10 seconds..."
ssh ssdb-2 "/etc/init.d/ssdb start"
sleep 10

echo "step 11: get 20000 keys from ssdb..."
./tools/get-keys.py -H haproxy-1

echo "step 12: stop ssdb-1 and wait 10 seconds..."
ssh ssdb-1 "/etc/init.d/ssdb stop"
sleep 10

echo "step 13: get 20000 keys from ssdb..."
./tools/get-keys.py -H haproxy-1

ssh ssdb-1 "/etc/init.d/ssdb start"
