#!/usr/bin/env python

import argparse
import sys
import socket
import ssdblib


def parse_args(args):

    parser = argparse.ArgumentParser()
    parser.add_argument('-H', '--host', metavar='server_ip',
                        default='127.0.0.1',
                        help='server ip')
    parser.add_argument('-p', '--port', metavar='server_port',
                        default=8888, type=int,
                        help='server port')
    args = parser.parse_args()
    return args


if __name__ == '__main__':
    args = parse_args(sys.argv)

    host = socket.gethostbyname(args.host)
    ssdb = ssdblib.SSDBLib(host, args.port)

    print len(ssdb.get_keys())

    ssdb.close()
