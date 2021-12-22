# Test web-app to use with Pluralsight courses and Docker Deep Dive book
# Linux x64
# FROM ubuntu/apache2:2.4-21.10_beta
FROM ubuntu:hirsute

LABEL maintainer="mhteaching2703@gmail.com"

# Copy app to /src
COPY . /src
WORKDIR /src
# Install scripts
RUN /src/bin/install-apt.sh; \
    /src/bin/basic_tools.sh; \
    /src/bin/install-Apache2.sh; \
    /src/bin/switchhttps.sh; \
    /src/bin/install-PHP+Tools.sh;

EXPOSE 80 443
# CMD ["/bin/bash"]
# ENTRYPOINT ["/usr/sbin/apache2ctl start"]
# ENTRYPOINT ["service", "apache2 start"]
