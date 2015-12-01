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

if [ $# -lt 1 -o $# -gt 2 ]; then
    echo "usage: $0 <memcache> <number>"
    exit 1
fi

if [ $# -eq 1 ]; then
    memcache=$1
elif [ $# -eq 2 ]; then
    memcache=$1
    number=$2
fi

port=${port:-11211}
number=${number:-2000}
timeout=${timeout:-3}

# write to memcache
for i in $(seq 1 $number)
do
    set_key_value $memcache $port "key$i" "value$i"
done | grep STORED | wc -l
