FROM ubuntu:14.04

RUN apt-get update && \
    apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/*

RUN curl -L https://github.com/kelseyhightower/confd/releases/download/v0.11.0/confd-0.11.0-linux-amd64 -o /usr/local/bin/confd
RUN chmod +x /usr/local/bin/confd

RUN mkdir -p /etc/confd/templates
RUN mkdir -p /etc/confd/conf.d

COPY confd/nginx.toml /etc/confd/conf.d/
COPY confd/nginx.tmpl /etc/confd/templates/

CMD /usr/bin/confd -interval=60 -node=http://$ETCD