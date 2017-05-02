FROM debian

ENV VERSION=3_0_0_318

RUN apt-get update && \
  apt-get install -y wget \
  mono-vbnc \
  libmono-system-web4.0.cil \
  libmono-system-design4.0.cil \
  libmono-system-web-extensions4.0-cil \
  libmono-system-runtime-caching4.0-cil \
  flite \
  chromium

RUN mkdir /src && \
  cd /src && \
  wget -O homeseer.tgz "http://homeseer.com/updates3/hs3_linux_${VERSION}.tar.gz"

ADD run.sh /run.sh
RUN chmod +x /run.sh

VOLUME /data
EXPOSE 80/tcp 10401/tcp 10200/tcp 10300/tcp

CMD '/run.sh'
