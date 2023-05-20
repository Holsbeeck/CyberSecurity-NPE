#!/bin/bash

# Voorbereidingen voor Roxy installatie
sudo apt install curl -y
sudo mkdir /var/www/haproxy-wi
curl -o v6.1.0.0.tar.gz -L https://github.com/hap-wi/roxy-wi/archive/refs/tags/v6.1.0.0.tar.gz
sudo tar -xzf v6.1.0.0.tar.gz -C "/var/www/haproxy-wi" --strip-components=1
rm v6.1.0.0.tar.gz

# Installatie van Roxy-WI

sudo apt-get install apache2 python3 python3-pip python3-ldap rsync ansible python3-requests -y
sudo apt-get install python3-networkx python3-matplotlib python3-bottle python3-future python3-jinja2 python3-peewee python3-distro -y
sudo apt-get install python3-pymysql python3-psutil python3-paramiko netcat-traditional nmap net-tools lshw dos2unix libapache2-mod-wsgi-py3 openssl sshpass -y

sudo chown -R www-data:www-data /var/www/haproxy-wi/
sudo cp /var/www/haproxy-wi/config_other/httpd/roxy-wi_deb.conf /etc/apache2/sites-available/roxy-wi.conf
sudo a2ensite roxy-wi.conf
sudo a2enmod cgid ssl proxy_http rewrite
sudo pip3 install -r /var/www/haproxy-wi/config_other/requirements_deb.txt
sudo systemctl restart apache2

sudo pip3 install paramiko-ng 
sudo chmod +x /var/www/haproxy-wi/app/*.py 
sudo cp /var/www/haproxy-wi/config_other/logrotate/* /etc/logrotate.d/
sudo mkdir /var/lib/roxy-wi/
sudo mkdir /var/lib/roxy-wi/keys/
sudo mkdir /var/lib/roxy-wi/configs/
sudo mkdir /var/lib/roxy-wi/configs/hap_config/
sudo mkdir /var/lib/roxy-wi/configs/kp_config/
sudo mkdir /var/lib/roxy-wi/configs/nginx_config/
sudo mkdir /var/lib/roxy-wi/configs/apache_config/
sudo mkdir /var/log/roxy-wi/
sudo mkdir /etc/roxy-wi/
sudo mv /var/www/haproxy-wi/config_other/httpd/roxy-wi.conf /etc/roxy-wi
sudo openssl req -newkey rsa:4096 -nodes -keyout /var/www/haproxy-wi/app/certs/haproxy-wi.key -x509 -days 10365 -out /var/www/haproxy-wi/app/certs/haproxy-wi.crt -subj "/C=US/ST=Almaty/L=Springfield/O=Roxy-WI/OU=IT/CN=*.roxy-wi.org/emailAddress=aidaho@roxy-wi.org"
sudo chown -R www-data:www-data /var/www/haproxy-wi/
sudo chown -R www-data:www-data /var/lib/roxy-wi/
sudo chown -R www-data:www-data /var/log/roxy-wi/
sudo chown -R www-data:www-data /etc/roxy-wi/
sudo systemctl daemon-reload      
sudo systemctl restart apache2
sudo systemctl restart rsyslog

# Database aspect

sudo /var/www/haproxy-wi/app/create_db.py
sudo chown -R www-data:www-data /var/www/haproxy-wi/
sudo chown -R www-data:www-data /var/lib/roxy-wi/