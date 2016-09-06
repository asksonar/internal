# Use phusion/passenger-full as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/passenger-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/passenger-ruby22:0.9.18

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

# install inotify and rsync so we can automatically copy our src folder
RUN apt-get update
RUN apt-get -y install rsync

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# write our own nginx.conf
ADD nginx/nginx.conf /etc/nginx/nginx.conf
# add environment variables to nginx
ADD nginx/main.d/env.conf /etc/nginx/main.d/env.conf
# remove the default site
RUN rm /etc/nginx/sites-enabled/default
# set my default site
ADD nginx/sites-enabled/server.conf /etc/nginx/sites-enabled/server.conf

# startup scripts that can be passed to /sbin/my_init -- COMMAND ARGUMENTS...
# exit 0 if you want to just run it and then shut it down
ADD my_startup /etc/my_startup
RUN chmod +x /etc/my_startup/start_thin.sh

RUN mkdir -p /etc/my_init.d

# add our ssl certs
ADD ssl /etc/ssl

# enable nginx
RUN rm -f /etc/service/nginx/down

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

# for thin to use
RUN mkdir -p /tmp/pids
RUN mkdir -p /tmp/sockets

WORKDIR /home/app/webapp
