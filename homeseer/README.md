# HomeSeer
All the needed bits to containerize HomeSeer.

Here is a list of ports that you may want to expose:
- Port 80 WebUI
- Port 10401 Speaker Clients
- Port 10200 HSTouch
- Port 10300 myHS

# Example
```
docker run \
  --name homeseer \
  -v </path/to/data>/config:/HomeSeer/Config \
  -v </path/to/data>/data:/HomeSeer/Data \
  -v </path/to/data>/scripts:/HomeSeer/scripts \
  -p 80:80 \
  -p 10401:10401 \
  -p 10200:10200 \
  -p 10300:10300 \
  cbolt/homeseer
```
