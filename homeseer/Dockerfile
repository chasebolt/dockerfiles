FROM debian:latest

ENV VERSION=3_0_0_318

RUN apt-get update \
    && apt-get install -y \
        curl \
        mono-vbnc \
        libmono-system-web4.0.cil \
        libmono-system-design4.0.cil \
        libmono-system-web-extensions4.0-cil \
        libmono-system-runtime-caching4.0-cil \
        flite \
        chromium

RUN curl -o tini.deb "https://github.com/krallin/tini/releases/download/v0.14.0/tini_0.14.0-amd64.deb" \
    && dpkg -i tini.deb \
    && rm tini.deb

RUN curl -o homeseer.tgz "http://homeseer.com/updates3/hs3_linux_${VERSION}.tar.gz" \
    && tar -xzo -C / -f /homeseer.tgz \
    && rm homeseer.tgz

COPY ["run.sh", "/"]

ENTRYPOINT ["tini", "/run.sh"]
