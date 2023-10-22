#!/usr/bin/env bash
# This script sets up your web server for the deployment of web static

apt -y install nginx

if [ ! -d "/data/" ]
then
	mkdir "/data/"
fi

if [ ! -d "/data/web_static/" ]
then
        mkdir "/data/web_static/"
fi

if [ ! -d "/data/web_static/releases/" ]
then
        mkdir "/data/web_static/releases/"
fi

if [ ! -d "/data/web_static/shared/ " ]
then
        mkdir "/data/web_static/shared/"
fi

if [ ! -d "/data/web_static/releases/test/" ]
then
        mkdir "/data/web_static/releases/test/"
fi

if [ ! -e "/data/web_static/releases/test/index.html" ]
then
        echo "
<html>
  <head>
  </head>
  <body>
    Holberton School
  </body>
</html>" > "/data/web_static/releases/test/index.html"
fi

if [ ! -L "/data/web_static/current" ]
then
	rm /data/web_static/current
	ln -s "/data/web_static/releases/test/" "/data/web_static/current"
else
	rm /data/web_static/current
        ln -s "/data/web_static/releases/test/" "/data/web_static/current"
fi

chown -R ubuntu /data/
chgrp -R ubuntu /data/

printf %s "server {
    listen 80 default_server;
    listen [::]:80 default_server;
    add_header X-Served-By $HOSTNAME;
    root   /var/www/html;
    index  index.html index.htm;

    location /hbnb_static {
        alias /data/web_static/current;
        index index.html index.htm;
    }

    location /redirect_me {
        return 301 http://cuberule.com/;
    }

    error_page 404 /404.html;
    location /404 {
      root /var/www/html;
      internal;
    }
}" > /etc/nginx/sites-available/default

service nginx restart
