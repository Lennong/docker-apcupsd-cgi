#!/bin/bash

# remove sample and create empty hosts file
rm /etc/apcupsd/hosts.conf && touch /etc/apcupsd/hosts.conf

# copy config files
cp /opt/multimon.conf /etc/apcupsd/multimon.conf
cp /opt/apcupsd.css /etc/apcupsd/apcupsd.css

# populate two arrays with host and UPS names
HOSTS=( $UPSHOSTS )
NAMES=( $UPSNAMES )

# add monitors to hosts.conf for each host and UPS name combo
for ((i=0;i<${#HOSTS[@]};i++))
    do
        echo "MONITOR ${HOSTS[$i]} \"${NAMES[$i]}\"" >> /etc/apcupsd/hosts.conf
        echo "MONITOR ${HOSTS[$i]} \"${NAMES[$i]}\""
done

# start fcgiwrap
/etc/init.d/fcgiwrap start
nginx -g 'daemon off;'
