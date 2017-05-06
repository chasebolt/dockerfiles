squid caching container. has a simple caching config that can be overwritten at `/etc/squid/squid.conf`. `CACHE_SIZE_*` is in MB units.

# Example Usage
```
docker run -it --rm \
  --name squid \
  -p 3128:3128 \
  -e 'CACHE_SIZE_MEM=2048' \
  -e 'CACHE_SIZE_DISK=10240' \
  cbolt/squid
```
