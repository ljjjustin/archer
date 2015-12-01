import pyssdb


class SSDBLib(object):

    def __init__(self, host='127.0.0.1', port=8888):
        self.host = host
        self.port = port
        self.hkey = 'ssdbhatest'
        self.client = self.get_client(host, port)

    def get_client(self, host, port):
        return pyssdb.Client(host=host, port=port)

    def get_keys(self):
        start = ''
        all_keys = []

        while True:
            keys = self.client.hkeys(self.hkey, start, '', 500)
            nkey = len(keys)
            if nkey == 0:
                break
            else:
                start = keys[-1]
            all_keys.extend(keys)

        return all_keys

    def flush_all(self):
        return self.client.hclear(self.hkey)

    def get(self, key):
        return self.client.hget(self.hkey, key)

    def set(self, key, value):
        return self.client.hset(self.hkey, key, value)

    def delete(self, key):
        return self.client.hdel(self.hkey, key)

    def close(self):
        self.client.close()
