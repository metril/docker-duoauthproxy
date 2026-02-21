FROM debian:stable-slim

LABEL maintainer="metril"
LABEL org.opencontainers.image.source="https://github.com/metril/docker-duoauthproxy"
LABEL org.opencontainers.image.description="Duo Authentication Proxy built from source"

ARG DUO_VERSION=""

RUN \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    wget ca-certificates build-essential libffi-dev perl zlib1g-dev && \
  useradd duo_authproxy_svc && \
  groupadd duo_authproxy_grp && \
  if [ -n "$DUO_VERSION" ]; then \
    wget -q "https://dl.duosecurity.com/duoauthproxy-${DUO_VERSION}-src.tgz" -O /duoauthproxy-src.tgz; \
  else \
    wget -q "https://dl.duosecurity.com/duoauthproxy-latest-src.tgz" -O /duoauthproxy-src.tgz; \
  fi && \
  tar xzf /duoauthproxy-src.tgz -C / && \
  rm /duoauthproxy-src.tgz && \
  cd /duoauthproxy-*-src && \
  make && \
  cd duoauthproxy-build && \
  ./install \
    --install-dir /opt/duoauthproxy \
    --service-user duo_authproxy_svc \
    --log-group duo_authproxy_grp \
    --create-init-script yes && \
  rm -rf /duoauthproxy-* && \
  apt-get purge -y build-essential wget && \
  apt-get autoremove -y && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

EXPOSE 1812-1818/udp 18120/udp 636/tcp 389/tcp
VOLUME ["/opt/duoauthproxy/conf/", "/opt/duoauthproxy/log/"]
ENTRYPOINT ["/opt/duoauthproxy/bin/authproxy"]
