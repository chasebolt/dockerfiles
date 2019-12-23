FROM alpine:latest

RUN apk --no-cache add \
      tini \
      thttpd

RUN mkdir /www

ENTRYPOINT ["tini", "--", "/usr/sbin/thttpd", "-D", "-d", "/www", "-l", "/dev/stdout"]
