FROM mono:5.14.0.177

ENV DEBIAN_FRONTEND noninteractive
ENV VERSION="3_0_0_435"
ENV TIMEZONE="America/Los_Angeles"

RUN apt-get update && apt-get install -y \
      mono-complete \
      wget \
      flite \
      chromium \
      locales \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV LC_ALL="en_US.UTF-8"
ENV LANG="en_US.UTF-8"
ENV LANGUAGE="en_US.UTF-8"

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen \
    && echo "$TIMEZONE" > /etc/timezone \
    && dpkg-reconfigure -f noninteractive tzdata

RUN wget -O tini.deb "https://github.com/krallin/tini/releases/download/v0.14.0/tini_0.14.0-amd64.deb" \
    && dpkg -i tini.deb \
    && rm tini.deb

RUN wget -O homeseer.tgz "http://homeseer.com/updates3/hs3_linux_${VERSION}.tar.gz" \
    && mkdir /data \
    && tar -xzo -C /data -f /homeseer.tgz \
    && rm homeseer.tgz

COPY ["run.sh", "/"]

ENTRYPOINT ["tini", "--", "/run.sh"]
