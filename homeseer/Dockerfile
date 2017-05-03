FROM debian:latest

ENV VERSION=3_0_0_318

RUN apt-get update \
    && apt-get install -y \
        wget \
        mono-vbnc \
        libmono-system-web4.0.cil \
        libmono-system-design4.0.cil \
        libmono-system-web-extensions4.0-cil \
        libmono-system-runtime-caching4.0-cil \
        flite \
        chromium

RUN wget -O tini.deb "https://github.com/krallin/tini/releases/download/v0.14.0/tini_0.14.0-amd64.deb" \
    && dpkg -i tini.deb \
    && rm tini.deb

RUN wget -O homeseer.tgz "http://homeseer.com/updates3/hs3_linux_${VERSION}.tar.gz" \
    && tar -xz -C / -f /homeseer.tgz \
    && chown -R root:root /HomeSeer \
    && rm homeseer.tgz

ADD ["run.sh", "/"]

ENTRYPOINT ["tini", "/run.sh"]
