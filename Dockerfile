FROM lambci/lambda:build-provided
# FROM registry.access.redhat.com/ubi8/ubi-minimal:8.4
# FROM redhat/ubi8/ubi-minimal:8.4

LABEL maintainer="TychoDev <cloud.ops@tychodev.com>"

ENV PYTHON_VERSION=3.9 \
    PATH=$HOME/.local/bin/:$PATH \
    PYTHONUNBUFFERED=1 \
    PYTHONIOENCODING=UTF-8 \
    PIP_NO_CACHE_DIR=off \
    NODEJS_VERSION=14 \
    PATH=$HOME/.local/bin/:$PATH \
    npm_config_loglevel=warn \
    npm_config_unsafe_perm=true

# The lambci/lambda Image does not have MicroDNF installed, and requires the use of YUM
# https://www.redhat.com/en/blog/introducing-red-hat-enterprise-linux-atomic-base-image

RUN yum update -y \
    && yum install -y nodejs \
    && yum install -y npm \
    && yum install -y python39 \
    && yum install -y findutils \
    && yum clean all \
    && rm -rf /var/cache/* /var/log/dnf* /var/log/yum.*

RUN npm install --global yarn \
    && npm install -g serverless \
    && npm config set prefix /usr/local

RUN pip3 install poetry
    
RUN node --version \ 
    && npm --version \ 
    && yarn --version \
    && python3 --version \ 
    && pip3 --version \
    && serverless --version

# USER 1001

CMD ["echo", "This is a 'Purpose Built Image', It is not meant to be ran directly"]
