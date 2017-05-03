FROM phusion/passenger-ruby22

WORKDIR /home/app/webapp

COPY ["nginx.conf", "/etc/nginx/sites-available/default"]
COPY ["app", "/home/app/webapp/"]

RUN bundle config --global silence_root_warning true \
    && bundle install --deployment \
    && chown -R app:app /home/app \
    && rm -f /etc/service/nginx/down
