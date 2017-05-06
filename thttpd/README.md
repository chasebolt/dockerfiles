# Example Usage
```
docker run --it --rm \
  --name thttpd \
  -p '80:80' \
  -v '</path/to/data>/www:/www' \
  cbolt/thttpd
```
