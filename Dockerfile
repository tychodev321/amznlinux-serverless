FROM registry.gitlab.com/tychodev1/gitlab-coe/images/app/ubi-nodejs:latest

LABEL maintainer="TychoDev <cloud.ops@tychodev.com>"

RUN npm install -g serverless
RUN serverless --version

CMD ["echo", "This is a 'Purpose Built Image', It is not meant to be ran directly"]
