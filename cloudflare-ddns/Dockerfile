FROM alpine:latest

ENV CF_EMAIL ''
ENV CF_KEY ''
ENV ZONE_NAME ''
ENV SUBDOMAIN ''
ENV RUN_EVERY 3600

RUN apk --no-cache add \
    ruby \
    ruby-json \
    ruby-bundler \
    ca-certificates

ADD ["Gemfile", "Gemfile.lock", "/"]
RUN bundle config --global silence_root_warning true && bundle install

ADD ["ddns.rb", "start.sh", "/"]
RUN chmod +x /start.sh /ddns.rb

ENTRYPOINT ["/start.sh"]
CMD ["/ddns.rb"]
