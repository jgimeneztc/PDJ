FROM wordpress

USER root
RUN DEBIAN_FRONTEND=noninteractive apt-get update -qq \
    && apt-get -y install --no-install-recommends \
        python-pip \
        python-yaml \
        apt-transport-https \
        ca-certificates \
        curl \
        software-properties-common \
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

RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

RUN curl -fL https://github.com/bitrise-io/bitrise/releases/download/1.20.0/bitrise-$(uname -s)-$(uname -m) > /usr/local/bin/bitrise \
    && chmod +x /usr/local/bin/bitrise

USER wordpress
