# HomeSeer
All the needed bits to containerize HomeSeer.

For persistance data, you can mount over /HomeSeer and the container will copy over the most recent version at runtime.

Here is a list of ports that you may want to expose:
- Port 80 WebUI
- Port 10401 Speaker Clients
- Port 10200 HSTouch
- Port 10300 myHS

# Example Usage
```
docker run -it --rm \
  --name homeseer \
  -v </path/to/data>/homeseer:/HomeSeer \
  -p 80:80 \
  -p 10401:10401 \
  -p 10200:10200 \
  -p 10300:10300 \
  cbolt/homeseer
```
