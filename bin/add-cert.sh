cd /tmp
openssl req -new -newkey rsa:4096 -days 3650 -nodes -x509 -subj \
    "/C=AT/ST=UpperAustria/L=Hagenberg/O=FHOOE/CN=MH" \
    -keyout ./ssl.key -out ./ssl.crt

cp ssl.crt /etc/apache2/ssl/ssl.crt
cp ssl.key /etc/apache2/ssl/ssl.key

# <VirtualHost *:443>
#  SSLEngine on
#  SSLCertificateFile /etc/apache2/ssl/ssl.crt
#  SSLCertificateKeyFile /etc/apache2/ssl/ssl.key
#  ....
# </VirtualHost>

