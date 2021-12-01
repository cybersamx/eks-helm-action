FROM python:3.10.0-alpine3.14

LABEL maintainer="Samuel Chow <cybersamx+github@gmail.com>"

RUN apk add --no-cache --repository='http://dl-cdn.alpinelinux.org/alpine/edge/testing' \
    kubectl=1.22.4-r0 \
    helm=3.7.1-r0
RUN pip install awscli

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
