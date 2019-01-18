
FROM wordpress:5.0.3-php7.1-apache

USER root
RUN DEBIAN_FRONTEND=noninteractive apt-get update -qq \
    && apt-get -y install --no-install-recommends \
        python-pip \
        python-yaml \
        apt-transport-https \
        ca-certificates \
        curl \
        software-properties-common

USER wordpress
