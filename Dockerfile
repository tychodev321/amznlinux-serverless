FROM public.ecr.aws/amazonlinux/amazonlinux:2
# https://hub.docker.com/_/amazonlinux

LABEL maintainer=""

ENV PYTHON_VERSION=3.10.10 \
    PYTHON_PRFIX=3.10 \
    PATH=$HOME/.local/bin/:$PATH \
    PYTHONUNBUFFERED=1 \
    PYTHONIOENCODING=UTF-8 \
    PIP_NO_CACHE_DIR=off \
    NODEJS_VERSION=16 \
    PATH=$HOME/.local/bin/:$PATH \
    npm_config_loglevel=warn \
    npm_config_unsafe_perm=true

# Amazon Linux only supports YUM
# https://www.redhat.com/en/blog/introducing-red-hat-enterprise-linux-atomic-base-image

RUN yum update -y \
    && yum -y install gcc openssl-devel bzip2-devel libffi-devel curl wget tar gzip make which  \
    && curl -sL https://rpm.nodesource.com/setup_${NODEJS_VERSION}.x | bash - \
    && yum install -y nodejs \
    && yum install -y findutils \
    && yum install -y zip \
    && yum clean all \
    && rm -rf /var/cache/* /var/log/dnf* /var/log/yum.*

# Download Python
WORKDIR /opt

RUN npm install --global yarn \
    && npm config set prefix /usr/local

RUN wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz \
    && tar xzf Python-${PYTHON_VERSION}.tgz

# Install and Configure Python
WORKDIR /opt/Python-${PYTHON_VERSION}

RUN ./configure --enable-optimizations \
    && make altinstall \
    && ln -s $(which python3.10) /usr/local/bin/python3 \ 
    && rm -f /opt/Python-${PYTHON_VERSION}.tgz \
    && curl -O https://bootstrap.pypa.io/get-pip.py \
    && python3 get-pip.py \
    && rm get-pip.py

WORKDIR /

# Make sure to upgrade pip3
RUN pip3 install --upgrade pip && pip3 install poetry
    
RUN node --version \ 
    && npm --version \ 
    && yarn --version \
    && python3 --version \ 
    && pip3 --version

# USER 1001

CMD ["echo", "This is a 'Purpose Built Image', It is not meant to be ran directly"]
