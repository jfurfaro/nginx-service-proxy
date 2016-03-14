FROM alpine:3.1

ENV CONFD_VERSION=0.11.0

# Statically build confd for Alpine Linux :)
RUN echo "http://dl-2.alpinelinux.org/alpine/latest-stable/community" >> /etc/apk/repositories && \
    apk add --update go git netcat-openbsd gcc musl-dev && \
    git clone https://github.com/kelseyhightower/confd.git /src/confd && \
    cd /src/confd/src/github.com/kelseyhightower/confd/ && \
    GOPATH=/src/confd/vendor:/src/confd go build -a -installsuffix cgo -ldflags '-extld ld -extldflags -static' -x . && \
    mv ./confd /bin/ && \
    chmod +x /bin/confd && \
    apk del go git gcc musl-dev && \
    rm -rf /var/cache/apk/* /src

RUN mkdir -p /etc/confd/templates
RUN mkdir -p /etc/confd/conf.d

COPY confd/nginx.toml /etc/confd/conf.d/
COPY confd/nginx.tmpl /etc/confd/templates/

ENTRYPOINT ["confd"]