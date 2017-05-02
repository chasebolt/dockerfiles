FROM phusion/passenger-ruby22

RUN rm -f /etc/service/nginx/down

COPY my_init.d/* /etc/my_init.d/
RUN chmod +x /etc/my_init.d/*
