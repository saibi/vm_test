FROM ubuntu:latest
LABEL "Author"="saibi"
LABEL "Project"="nano"
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y apache2 git 
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
EXPOSE 80
WORKDIR /var/www/html
VOLUME /var/log/apache2
ADD nano.tar.bz2 /var/www/html
COPY nano.tar.bz2 /var/www/html

