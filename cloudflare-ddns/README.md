# Example Usage
```
docker run --rm -it \
-e 'CF_EMAIL=myemail@gmail.com' \
-e 'CF_KEY=XXXXXXXXX' \
-e 'SUBDOMAIN=hello' \
-e 'ZONE_NAME=world.com' \
-e 'RUN_EVERY=3600' \
cbolt/cloudflare-ddns
```
