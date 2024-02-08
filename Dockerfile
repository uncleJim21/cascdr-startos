FROM oven/bun:canary-alpine

ARG ARCH

RUN apk add --no-cache \
  bash \
  curl \
  iproute2 \
  yq \
  tini

COPY ./cascdr-vendor /cascdr-vendor

WORKDIR /cascdr-vendor

RUN bun install

ADD ./docker_entrypoint.sh /usr/local/bin/docker_entrypoint.sh
RUN chmod +x /usr/local/bin/docker_entrypoint.sh
ADD ./check-rest.sh /usr/local/bin/check-rest.sh
RUN chmod +x /usr/local/bin/check-rest.sh
ADD ./migrations /usr/local/bin/migrations
RUN chmod a+x /usr/local/bin/migrations/*

EXPOSE 3003

ENTRYPOINT ["/usr/local/bin/docker_entrypoint.sh"]
