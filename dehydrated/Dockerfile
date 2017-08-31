FROM python:2-alpine

RUN apk --no-cache add \
      tini \
      git \
      bash \
      curl \
      openssl \
      gcc \
      openssl-dev \
      libffi-dev \
      libc-dev

RUN git clone --depth 1 https://github.com/lukas2511/dehydrated.git /opt/dehydrated \
    && pip install requests[security] dns-lexicon --no-cache-dir

COPY ["hook.sh", "run.sh", "/"]
COPY ["config", "/etc/dehydrated/"]

ENTRYPOINT ["tini", "--", "/run.sh"]
