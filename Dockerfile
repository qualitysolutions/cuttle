
FROM golang:alpine

# Install go + build dependencies
RUN apk add --update git

# Get and build Cuttle
RUN mkdir -p /opt/cuttle \
    && cd /opt/cuttle \
    && GOPATH=`pwd` go get github.com/mrkschan/cuttle

# Copy config
COPY cuttle.yml /opt/cuttle/config/

# Clean up (trims image size)
RUN apk del git && rm -rf /var/cache/apk/*

EXPOSE 3128
CMD cd /opt/cuttle && bin/cuttle -f config/cuttle.yml