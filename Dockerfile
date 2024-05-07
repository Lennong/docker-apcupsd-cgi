# APC UPS Power Management Web Interface (from bitnami/minideb:bullseye, fcgiwrap, apcupsd-cgi)
FROM bitnami/minideb:bullseye

# update
RUN apt-get -y update && apt-get -y upgrade
 
# install
RUN apt-get -y install nginx-light apcupsd-cgi fcgiwrap

ADD aapcupsd-hosts.conf /etc/apcupsd/hosts.conf
ADD /config/multimon.conf /etc/apcupsd/multimon.conf
ADD /config/apcupsd.css /etc/apcupsd/apcupsd.css
ADD startup.sh /opt/startup.sh
ADD nginx.conf /etc/nginx/nginx.conf

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
 && ln -sf /dev/stderr /var/log/nginx/error.log

# clean
RUN apt-get clean

# Port
EXPOSE 80

CMD /opt/startup.sh
