FROM alpine:latest

RUN apk --no-cache add \
      tini \
      ruby \
      ruby-json \
      ruby-bundler \
      ca-certificates

COPY ["ddns.rb", "Gemfile", "Gemfile.lock", "/"]

RUN bundle config --global silence_root_warning true \
    && bundle install --deployment

ENTRYPOINT ["tini", "/ddns.rb"]
