#!/bin/bash

# Voorbereidingen voor Roxy installatie
sudo apt install apache2 curl -y
sudo mkdir /var/www/haproxy-wi

# Download 
curl -o v6.1.0.0.tar.gz -L https://github.com/hap-wi/roxy-wi/archive/refs/tags/v6.1.0.0.tar.gz

# Extract 
tar -xzf v6.1.0.0.tar.gz -C "/var/www/haproxy-wi" --strip-components=1

# Clean up
rm v6.1.0.0.tar.gz

echo "Roxy-WI repository is succesvol binnengehaald"