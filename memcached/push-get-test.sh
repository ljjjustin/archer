#!/bin/bash

# Sanitize language settings to avoid commands bailing out
# with "unsupported locale setting" errors.
unset LANG
unset LANGUAGE
LC_ALL=C
export LC_ALL

# Make sure umask is sane
umask 022

# Keep track of the top directory
TOPDIR=$(cd $(dirname "$0") && pwd)

source "${TOPDIR}/memlib"

if [ $# -lt 2 -o $# -gt 3 ]; then
    echo "usage: $0 <memcache1> <memcache2> <number>"
    exit 1
fi

if [ $# -eq 2 ]; then
    memcache1=$1
    memcache2=$2
elif [ $# -eq 3 ]; then
    memcache1=$1
    memcache2=$2
    number=$3
fi

port=${port:-11211}
number=${number:-2000}
timeout=${timeout:-3}

# write to memcache
pushed_keys=0
getted_keys=0
for i in $(seq 1 $number)
do
    pushed_keys=$((pushed_keys+=`set_key_value $memcache1 $port "key$i" "value$i" | grep STORED | wc -l`))
    getted_keys=$((getted_keys+=`get_key_value $memcache2 $port "key$i" | grep value | wc -l`))
done

echo "pushed: $pushed_keys"
echo "getted: $getted_keys"
