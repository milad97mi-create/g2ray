FROM debian:bookworm-slim

# Copy files
COPY setup.sh /tmp/setup.sh
COPY config.json /etc/xray/g2ray.json
COPY show-link.sh /usr/local/bin/show-link.sh
COPY start.sh /usr/local/bin/start.sh

# Install dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       bash \
       curl \
       wget \
       unzip \
       ca-certificates \
       openssl \
       uuid-runtime \
       tmux \
       jq \
       nodejs \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /etc/xray \
    && chmod +x /tmp/setup.sh \
    && /tmp/setup.sh \
    && rm /tmp/setup.sh \
    && chmod +x /usr/local/bin/show-link.sh \
    && chmod +x /usr/local/bin/start.sh

EXPOSE 443

# IMPORTANT: use your start script, not xray directly
CMD ["/usr/local/bin/start.sh"]
