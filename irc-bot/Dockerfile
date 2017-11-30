FROM ruby:2-alpine

RUN apk --no-cache add \
      tini

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY ["bot.rb", "Gemfile", "Gemfile.lock", "/usr/src/app/"]
RUN bundle install

ENTRYPOINT ["tini", "--", "ruby", "./bot.rb"]
