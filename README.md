# apcupsd-cgi
Docker - APC UPS Power Management Web Interface (from nginx:latest, fcgiwrap, apcupsd-cgi)

# Requirements
This is the APC UPS Power Management Web Interface, so it is necessary to have an [APC UPS](https://www.apc.com/) that supports monitoring (USB cable or network). 
You have to install the [apcupsd daemon](http://www.apcupsd.org/) on the host machine(s).

## Docker apcupsd-cgi
The docker image is Debian buster based, with nginx-light as web server, fcgiwrap as cgi server and obviously apcupsd-cgi. 

Apcupsd-cgi is configured to search and connect apcupsd daemon in the host machine IP on standard port 3551. Nginx is configured to conncet with fcgiwrap (CGI server) and to serve multimon.cgi directly on port 80. 
As explained, the container exposes port 80, if as I think port 80 on your host is already busy, redirect it to a free port. I use port 3552. 

To run docker container:
```
docker run -d -p 3552:80 -restart=unless-stopped --name apcupsd-cgi bnhf/apcupsd-cgi
```
If you use Portainer Stacks:
```yml
version: '3.7'
services:
  apcupsd-cgi:
      image: lennong05/apcupsd-cgi:latest
      container_name: apcupsd-cgi
      ports:
        - 3552:80
      environment:
        - UPSHOSTS=${UPSHOSTS} # Ordered list of hostnames or IP addresses of UPS connected computers (space separated, no quotes)
        - UPSNAMES=${UPSNAMES} # Matching ordered list of location names to display on status page (space separated, no quotes)
        - TZ=${TZ} # Timezone to use for status page -- UTC is the default
      restart: unless-stopped
```
Environment variables required for the above (or hardcode values into compose):

    UPSHOSTS (List of hostnames or IP addresses for computers with connected APC UPSs. Space separated without quotes.)
    UPSNAMES (List of names you'd like used in the WebUI. Order must match UPSHOSTS. Space separated without quotes.)
    TZ (Timezone for apcupsd-cgi to use when displaying information about individual UPS units)

## Docker apcupsd-cgi
Enter the application at address http://your_host_IP:3552

