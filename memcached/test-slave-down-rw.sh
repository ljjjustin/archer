#!/bin/bash

echo "step 1: flush memcache1 and memcache2..."
./flush-all.sh memcache1 memcache2;

echo "step 2: start push to haproxy..."
./push-get-test.sh localhost localhost 10000 & sleep 5
echo "step 3: stop memcache2..."
ssh memcache2 "service memcached stop"
echo "step 4: wait push finish..."
wait
echo "step 5: get from haproxy..."
./get-values.sh localhost 10000
echo "step 6: start memcache2..."
ssh memcache2 "service memcached start"
