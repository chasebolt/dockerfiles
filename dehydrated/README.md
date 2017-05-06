loads a domain.txt file and will create certs valid for haproxy deployments. defaults to challenge type http - you will need to run a http container [cbolt/thttpd](https://hub.docker.com/r/cbolt/thttpd/).

# Example Usage - http
```
docker run --it --rm \
  --name thttpd \
  -p '80:80' \
  -v '</path/to/data>/www:/www' \
  cbolt/thttpd

docker run -it --rm \
  --name dehydrated \
  -e 'STAGE=true' \
  -v '</path/to/data>/certs:/data/certs' \
  -v '</path/to/data>/haproxy:/data/haproxy' \
  -v '</path/to/data>/accounts:/data/accounts' \
  -v '</path/to/data>/www:/var/www/dehydrated' \
  -v '</path/to/data>/domains.txt:/etc/dehydrated/domains.txt' \
  cbolt/dehydrated
```

# Example Usage - dns
```
docker run -it --rm \
  --name dehydrated \
  -e 'STAGE=true' \
  -e 'CHALLENGE_TYPE=dns-01',
  -e 'PROVIDER=cloudflare',
  -e 'LEXICON_CLOUDFLARE_USERNAME=myemail@gmail.com',
  -e 'LEXICON_CLOUDFLARE_TOKEN=XXXXXXXXX',
  -v '</path/to/data>/certs:/data/certs' \
  -v '</path/to/data>/haproxy:/data/haproxy' \
  -v '</path/to/data>/accounts:/data/accounts' \
  -v '</path/to/data>/www:/var/www/dehydrated' \
  -v '</path/to/data>/domains.txt:/etc/dehydrated/domains.txt' \
  cbolt/dehydrated
```
