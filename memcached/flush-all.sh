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

if [ $# -lt 1 ]; then
    echo "usage: $0 <memcache1> [memcache2]"
    exit 1
fi

port=${port:-11211}
timeout=${timeout:-3}

# flush all data
for host in $@
do
    flush_all $host $port
    sleep 2
done
