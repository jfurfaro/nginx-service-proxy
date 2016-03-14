FROM smebberson/alpine-confd:latest

RUN mkdir -p /etc/confd/templates
RUN mkdir -p /etc/confd/conf.d

COPY confd/nginx.toml /etc/confd/conf.d/
COPY confd/nginx.tmpl /etc/confd/templates/

CMD confd -interval=60 -node=http://$ETCD