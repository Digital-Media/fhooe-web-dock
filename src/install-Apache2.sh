#!/bin/bash
# Apache2
echo ServerName localhost >> /etc/apache2/apache2.conf
a2enmod rewrite
