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

if [ $# -lt 2 -o $# -gt 3 ]; then
    echo "usage: $0 <ssdb1> <ssdb2> <number>"
    exit 1
fi

if [ $# -eq 2 ]; then
    ssdb1=$1
    ssdb2=$2
elif [ $# -eq 3 ]; then
    ssdb1=$1
    ssdb2=$2
    number=$3
fi

number=${number:-2000}

echo -n "put: "
echo $($TOPDIR/put-keys.py -H "$ssdb1" -c $number)
echo -n "get: "
echo $($TOPDIR/get-keys.py -H "$ssdb2")
