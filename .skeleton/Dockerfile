FROM alpine:latest

RUN apk --no-cache add \
      tini

COPY ["run.sh", "/"]

ENTRYPOINT ["tini", "--", "/run.sh"]
