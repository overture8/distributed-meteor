FROM dockerfile/haproxy
MAINTAINER Phil McClure <phil.mcclure@gmail.com>

# Install confd
RUN curl -L https://github.com/kelseyhightower/confd/releases/download/v0.5.0/confd-0.5.0-linux-amd64 -o confd
RUN mv confd /usr/local/bin/confd
RUN chmod +x /usr/local/bin/confd

# Create directories
RUN mkdir -p /etc/confd/{conf.d,templates}

# Add confd files
ADD ./haproxy.cfg.tmpl /etc/confd/templates/haproxy.cfg.tmpl
ADD ./haproxy.toml /etc/confd/conf.d/haproxy.toml

# Add boot script
ADD ./confd-watch.sh /usr/local/bin/confd-watch.sh
RUN chmod +x /usr/local/bin/confd-watch.sh
