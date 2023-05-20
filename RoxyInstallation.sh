#!/bin/bash

# Installatie van Roxy-WI
apt-get install apache2 python3 python3-pip python3-ldap rsync ansible python3-requests -y
apt-get install python3-networkx python3-matplotlib python3-bottle python3-future python3-jinja2 python3-peewee python3-distro -y
apt-get install python3-pymysql python3-psutil python3-paramiko netcat-traditional nmap net-tools lshw dos2unix libapache2-mod-wsgi-py3 openssl sshpass curl -y
mkdir /var/www/haproxy-wi
curl -o v6.1.0.0.tar.gz -L https://github.com/hap-wi/roxy-wi/archive/refs/tags/v6.1.0.0.tar.gz
tar -xzf v6.1.0.0.tar.gz -C "/var/www/haproxy-wi" --strip-components=1
rm v6.1.0.0.tar.gz

chown -R www-data:www-data /var/www/haproxy-wi/
cp /var/www/haproxy-wi/config_other/httpd/roxy-wi_deb.conf /etc/apache2/sites-available/roxy-wi.conf
a2ensite roxy-wi.conf
a2enmod cgid ssl proxy_http rewrite
pip3 install -r /var/www/haproxy-wi/config_other/requirements_deb.txt
systemctl restart apache2

pip3 install paramiko-ng 
chmod +x /var/www/haproxy-wi/app/*.py 
cp /var/www/haproxy-wi/config_other/logrotate/* /etc/logrotate.d/
mkdir /var/lib/roxy-wi/
mkdir /var/lib/roxy-wi/keys/
mkdir /var/lib/roxy-wi/configs/
mkdir /var/lib/roxy-wi/configs/hap_config/
mkdir /var/lib/roxy-wi/configs/kp_config/
mkdir /var/lib/roxy-wi/configs/nginx_config/
mkdir /var/lib/roxy-wi/configs/apache_config/
mkdir /var/log/roxy-wi/
mkdir /etc/roxy-wi/
mv /var/www/haproxy-wi/config_other/httpd/roxy-wi.conf /etc/roxy-wi
openssl req -newkey rsa:4096 -nodes -keyout /var/www/haproxy-wi/app/certs/haproxy-wi.key -x509 -days 10365 -out /var/www/haproxy-wi/app/certs/haproxy-wi.crt -subj "/C=US/ST=Almaty/L=Springfield/O=Roxy-WI/OU=IT/CN=*.roxy-wi.org/emailAddress=aidaho@roxy-wi.org"
chown -R www-data:www-data /var/www/haproxy-wi/
chown -R www-data:www-data /var/lib/roxy-wi/
chown -R www-data:www-data /var/log/roxy-wi/
chown -R www-data:www-data /etc/roxy-wi/
systemctl daemon-reload      
systemctl restart apache2
systemctl restart rsyslog

# Database aspect

/var/www/haproxy-wi/app/create_db.py
chown -R www-data:www-data /var/www/haproxy-wi/
chown -R www-data:www-data /var/lib/roxy-wi/