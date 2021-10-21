FROM lambci/lambda:build-provided
# Required for building AWS Lambdas with OS dependent packages
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

# MicroDNF is recommended over YUM for Building Container Images
# https://www.redhat.com/en/blog/introducing-red-hat-enterprise-linux-atomic-base-image

#RUN echo -e '[docker-ce-stable]\nname=Docker CE Stable - $basearch\nbaseurl=https://download.docker.com/linux/centos/8/#$basearch/stable\nenabled=1\ngpgcheck=1\ngpgkey=https://download.docker.com/linux/centos/gpg' > /etc/yum.repos.d/docker.repo

RUN microdnf update -y \
    #&& microdnf --noplugins install --nodocs -y --enablerepo=docker-ce-stable docker-ce-cli \
    && microdnf module enable nodejs:14 \
    && microdnf install -y nodejs \
    && microdnf install -y npm \
    && microdnf install -y python39 \
    && microdnf install -y findutils \
    && microdnf clean all \
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
    #&& docker --version

# USER 1001

CMD ["echo", "This is a 'Purpose Built Image', It is not meant to be ran directly"]
