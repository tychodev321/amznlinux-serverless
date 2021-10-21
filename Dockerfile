FROM public.ecr.aws/amazonlinux/amazonlinux:2
# https://hub.docker.com/_/amazonlinux

LABEL maintainer="TychoDev <cloud.ops@tychodev.com>"

ENV PYTHON_VERSION=3.9.6 \
    PYTHON_PRFIX=3.9 \
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
    && yum -y install gcc openssl-devel bzip2-devel libffi-devel curl wget tar gzip make  \
    && curl -sL https://rpm.nodesource.com/setup_14.x | bash - \
    && yum install -y nodejs \
    && yum install -y findutils \
    && yum clean all \
    && rm -rf /var/cache/* /var/log/dnf* /var/log/yum.*

RUN cd /opt \
    && wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz \
    && tar xzf Python-${PYTHON_VERSION}.tgz \
    && cd Python-${PYTHON_VERSION} \
    && ./configure --enable-optimizations \
    && make altinstall \
    && rm -f /opt/Python-3.9.6.tgz
    

#RUN npm install --global yarn \
#    && npm install -g serverless \
#    && npm config set prefix /usr/local

RUN pip install poetry
    
#RUN node --version \ 
#    && npm --version \ 
#    && yarn --version \
#    && python3 --version \ 
#    && pip --version \
#    && serverless --version

RUN python3 --version && pip --version

# USER 1001

CMD ["echo", "This is a 'Purpose Built Image', It is not meant to be ran directly"]
