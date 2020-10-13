FROM --platform=${TARGETPLATFORM:-linux/amd64} alpine:latest
ARG TARGETPLATFORM

RUN set -x \
    # Runtime dependencies.
 && apk add --no-cache \
      dante-server \
   && rm -rf /tmp/*

# Default configuration
COPY sockd.conf /etc/

USER sockd

EXPOSE 1080

ENTRYPOINT ["/usr/sbin/sockd"]
