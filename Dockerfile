FROM registry.gitlab.com/tychodev1/gitlab-coe/images/cicd/ubi-nodejs:latest

LABEL maintainer="TychoDev <cloud.ops@tychodev.com>"

RUN npm install -g serverless \
    && npm config set prefix /usr/local
RUN serverless --version

USER 1001

CMD ["echo", "This is a 'Purpose Built Image', It is not meant to be ran directly"]
