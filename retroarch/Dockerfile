FROM ubuntu:xenial

ENV DEBIAN_FRONTEND noninteractive

RUN echo "deb http://ppa.launchpad.net/libretro/stable/ubuntu xenial main" > /etc/apt/sources.list.d/libretro.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 18DAAE7FECA3745F

RUN apt-get update && apt-get install -y \
      wget \
      xdg-utils \
      libretro-* \
      retroarch \
    && rm -rf /var/lib/apt/lists/*

RUN wget -O tini.deb "https://github.com/krallin/tini/releases/download/v0.14.0/tini_0.14.0-amd64.deb" \
    && dpkg -i tini.deb \
    && rm tini.deb

ENV HOME /home/user
ENV XDG_RUNTIME_DIR /home/user
RUN useradd --create-home --home-dir $HOME user
USER user

ENTRYPOINT ["tini", "--", "/usr/bin/retroarch"]
