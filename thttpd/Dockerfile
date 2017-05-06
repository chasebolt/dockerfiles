FROM alpine:latest

RUN apk --no-cache add \
      tini \
      thttpd

ENTRYPOINT ["tini", "/usr/sbin/thttpd", "-D", "-d", "/www", "-l", "-"]
