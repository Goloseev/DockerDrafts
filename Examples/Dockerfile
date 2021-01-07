# Version: 0.0.1
FROM ubuntu:14.04
MAINTAINER Yuri Trukhin <trukhinyuri@infoboxcloud.com>
ENV REFRESHED_AT 2014–10–16
RUN apt-get update
RUN apt-get install -y nginx
RUN echo 'Hi, I am in your container' >/usr/share/nginx/html/index.html
EXPOSE 80:8080
ENTRYPOINT ["/usr/sbin/nginx"]
