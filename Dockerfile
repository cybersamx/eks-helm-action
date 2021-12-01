FROM python:3.10.0-alpine3.14

LABEL maintainer="Samuel Chow <cybersamx+github@gmail.com>"

RUN apk add --no-cache \
    bash
RUN apk add --no-cache --repository='http://dl-cdn.alpinelinux.org/alpine/edge/testing' \
    kubectl \
    helm
RUN pip install awscli

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
