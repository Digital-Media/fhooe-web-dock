# Linux x64
FROM php:8-apache

LABEL maintainer="mhteaching2703@gmail.com"

# Copy app to /src
COPY . /src
WORKDIR /src
# Install scripts
RUN  /src/bin/install-apt.sh; \
     /src/bin/basic_tools.sh; \
     /src/bin/install-Apache2.sh \
     /src/bin/install-PHP+Tools.sh; \
     /src/bin/switchhttps.sh;
EXPOSE 80 443

# CMD [ "/usr/sbin/apache2ctl", "-DFOREGROUND" ]