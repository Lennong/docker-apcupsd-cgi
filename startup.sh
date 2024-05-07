#!/bin/bash

# copy config files if not already exists/configured
cp -n /opt/hosts.conf /etc/apcupsd/hosts.conf
cp -n /opt/multimon.conf /etc/apcupsd/multimon.conf
cp -n /opt/apcupsd.css /etc/apcupsd/apcupsd.css

# if no MONITOR case has been configured, 
# populate two arrays and add monitors to hosts.conf for each host and UPS name combo
if ! grep -w "^MONITOR" < "/etc/apcupsd/hosts.conf" > /dev/null; then
HOSTS=( $UPSHOSTS )
NAMES=( $UPSNAMES )
for ((i=0;i<${#HOSTS[@]};i++))
    do
        echo "MONITOR ${HOSTS[$i]} \"${NAMES[$i]}\"" >> /etc/apcupsd/hosts.conf
        echo "MONITOR ${HOSTS[$i]} \"${NAMES[$i]}\""
done
fi

# start fcgiwrap
/etc/init.d/fcgiwrap start
nginx -g 'daemon off;'
