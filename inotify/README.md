# Example Usage
```
docker run -it --rm \
  --name inotify \
  -e CONTAINER=haproxy \
  -v /data/certs:/data \
  -v /var/run/docker.sock:/var/run/docker.sock:ro \
  cbolt/inotify
```

# curl Options
For debug propose it's possible to pass additional curl options into the container. Just set the environment variable `CURL_OPTIONS=-v`.

# Signal
The default signal is `SIGHUP`. This behaviour can be overwritten, if you set the environment variable `SIGNAL=<signal>`.

# inotify Events
The default inotify events are `create,delete,modify,move`. This behaviour can be overwritten, if you set the environment variable `INOTIFY_EVENTS=<events>`.

# inotify Options
To define your own inotify options, overwrite the variable `INOTIFY_OPTONS=<your options>`.
