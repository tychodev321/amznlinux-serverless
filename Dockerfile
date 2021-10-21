FROM amazonlinux:2
# https://hub.docker.com/_/amazonlinux

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

# Amazon Linux only supports YUM
# https://www.redhat.com/en/blog/introducing-red-hat-enterprise-linux-atomic-base-image

RUN yum update -y \
    # && microdnf module enable nodejs:14 \
    # && microdnf install -y nodejs \
    # && microdnf install -y npm \
    && yum install -y python39 \
    && yum install -y python3-pip \
    && yum install -y findutils \
    && yum clean all \
    && rm -rf /var/cache/* /var/log/dnf* /var/log/yum.*

#RUN npm install --global yarn \
#    && npm install -g serverless \
#    && npm config set prefix /usr/local

RUN pip3 install poetry
    
#RUN node --version \ 
#    && npm --version \ 
#    && yarn --version \
#    && python3 --version \ 
#    && pip3 --version \
#    && serverless --version

RUN python3 --version && pip3 --version

# USER 1001

CMD ["echo", "This is a 'Purpose Built Image', It is not meant to be ran directly"]
