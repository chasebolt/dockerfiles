FROM alpine:latest

ENV CF_EMAIL ''
ENV CF_KEY ''
ENV ZONE_NAME ''
ENV SUBDOMAIN ''
ENV RUN_EVERY 3600

RUN apk --no-cache add \
      tini \
      ruby \
      ruby-json \
      ruby-bundler \
      ca-certificates

COPY ["ddns.rb", "Gemfile", "Gemfile.lock", "/"]

RUN bundle config --global silence_root_warning true \
    && bundle install

ENTRYPOINT ["tini", "/ddns.rb"]
