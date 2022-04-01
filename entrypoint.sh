#!/bin/bash

# Creating local certificates
mkdir certificates
openssl req -new -newkey rsa:2048 -days 365 -nodes -x509 -keyout certificates/localhost.key -out certificates/localhost.crt -subj "/C=GB/ST=London/L=London/O=Global Security/OU=IT Department/CN=example.com"

# Added delay
echo "[INFO]: Waiting for 10 sec"
sleep 10

# Checking for the Nginx Server ( Function)
echo "[INFO]: Starting the Nginx Service"
function check_nginx(){
    # To check for the time-out
    service nginx status
    retVal=$?
    if [ $retVal -ne 0 ]
    then
        echo "[INFO]: Nginx service not up. Retrying..."
        sleep 5
        service nginx start
        service nginx restart
        check_nginx
    else
        echo "[INFO]: Service of Nginx Up."
    fi
}

# Nginx Installation
apt update
apt install nginx -y

# Changing the configuration according to customized nginx-conf file.
cp nginx.conf /etc/nginx
# Checking for nginx service
check_nginx

# Starting the node app.
echo "[INFO]: Starting the Node application"
node index.js
