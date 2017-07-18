FROM php:7-apache

ENV DEBIAN_FRONTEND noninteractive

ENV STORAGE_DIR /tmp
ENV PROFILER_DIR /cachegrind

RUN apt-get update && apt-get install -y \
      git \
      graphviz \
      python \
    && rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 https://github.com/jokkedk/webgrind.git /var/www/html

RUN mkdir -p $STORAGE_DIR $PROFILER_DIR \
    && sed -i "s@storageDir = .*@storageDir = '$STORAGE_DIR';@" /var/www/html/config.php \
    && sed -i "s@profilerDir = .*@profilerDir = '$PROFILER_DIR';@" /var/www/html/config.php
