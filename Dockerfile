FROM gliderlabs/alpine

RUN apk update && \
    apk upgrade && \
    apk add bash

ADD .rubocop_common.yml .rubocop_common.yml
