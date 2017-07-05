FROM php:7-apache

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
      git \
      graphviz \
      python

RUN git clone --depth 1 https://github.com/jokkedk/webgrind.git /var/www/html
