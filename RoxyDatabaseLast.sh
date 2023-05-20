#!/bin/bash

cd /var/www/haproxy-wi/app
sudo ./create_db.py
sudo chown -R www-data:www-data /var/www/haproxy-wi/
sudo chown -R www-data:www-data /var/lib/roxy-wi/