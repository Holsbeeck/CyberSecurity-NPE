#!/bin/bash

cd /var/www/haproxy-wi/app
sudo ./create_db.py
sudo chown -R apache:apache /var/www/haproxy-wi/
sudo chown -R apache:apache /var/lib/roxy-wi/