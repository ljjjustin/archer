#!/usr/bin/env python

import argparse
import sys
import socket
import ssdblib
import uuid


def parse_args(args):

    parser = argparse.ArgumentParser()
    parser.add_argument('-H', '--host', metavar='server_ip',
                        default='127.0.0.1',
                        help='server ip')
    parser.add_argument('-p', '--port', metavar='server_port',
                        default=8888, type=int,
                        help='server port')
    parser.add_argument('-c', '--count', metavar='how many keys',
                        default=5000, type=int,
                        help='how many keys')
    args = parser.parse_args()
    return args


if __name__ == '__main__':
    args = parse_args(sys.argv)

    if args.count <= 0:
        sys.exit(-1)

    host = socket.gethostbyname(args.host)
    ssdb = ssdblib.SSDBLib(host, args.port)

    pushed_keys = 0
    for i in xrange(args.count):
        key = "key%s" % str(uuid.uuid4())
        value = "value%08d" % i
        if ssdb.set(key, value):
            pushed_keys += 1

    print pushed_keys
    ssdb.close()
