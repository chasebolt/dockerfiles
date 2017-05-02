# HomeSeer
All the needed bits to containerize HomeSeer. For persistent storage, bind
a volume to the container `/data`.

Here is a list of ports that you may want to expose:
- Port 80 WebUI
- Port 10401 Speaker Clients
- Port 10200 HSTouch
- Port 10300 myHS

# Running Example
```
docker run \
  --name homeseer \
  -v </path/to/data>:/data \
  -p 80:80 \
  -p 10401:10401 \
  -p 10200:10200 \
  -p 10300:10300 \
  cbolt/homeseer
```
