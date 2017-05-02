FROM phusion/passenger-ruby22

RUN rm -f /etc/service/nginx/down
COPY nginx.default /etc/nginx/sites-available/default

WORKDIR /home/app/webapp
COPY . /home/app/webapp/
RUN bundle config --global silence_root_warning 1
RUN bundle install --deployment
RUN chown -R app:app /home/app

EXPOSE 80 443
