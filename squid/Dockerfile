FROM alpine:latest

RUN apk --no-cache add \
      tini \
      squid \
      curl

COPY ["squid.conf", "/etc/squid/"]
COPY ["run.sh", "/"]

ENTRYPOINT ["tini", "--", "/run.sh"]
