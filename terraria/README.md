# Example Usage
```
docker run -it --rm \
  --name terraria \
  -v </path/to/data>:/data \
  -p 7777:7777/tcp \
  -p 7777:7777/udp \
  cbolt/terraria
```
