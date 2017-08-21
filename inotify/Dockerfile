FROM alpine:latest

RUN apk --no-cache add \
      tini \
      inotify-tools \
      curl

COPY ["run.sh", "/"]

ENTRYPOINT ["tini", "/run.sh"]
