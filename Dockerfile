
FROM wordpress:5.0.3-php7.1-apache

USER root
RUN DEBIAN_FRONTEND=noninteractive apt-get update -qq \
    && apt-get -y install --no-install-recommends \
    python-pip \
    python-yaml \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    && apt-get -y install gnupg2 \
    && pip install awscli \
    && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
    && apt-key fingerprint 0EBFCD88 \
    && add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/debian \
    $(lsb_release -cs) \
    stable" \
    && apt-get update -qq \ 
    && apt-get -y install --no-install-recommends \
    docker-ce \
    && curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

RUN wget --quiet https://releases.hashicorp.com/terraform/0.11.3/terraform_0.11.3_linux_amd64.zip \
  && unzip terraform_0.11.3_linux_amd64.zip \
  && mv terraform /usr/bin \
  && rm terraform_0.11.3_linux_amd64.zip

USER www-data
