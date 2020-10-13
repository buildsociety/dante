FROM alpine:3

RUN set -x \
    # Runtime dependencies.
 && apk add --no-cache \
      dante-server \
      curl \
    # Install dumb-init (avoid PID 1 issues).
    # https://github.com/Yelp/dumb-init
 && curl -Lo /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.1.3/dumb-init_1.1.3_amd64 \
 && chmod +x /usr/local/bin/dumb-init \
    # Clean up.
 && rm -rf /tmp/* \
 && apk del --purge curl

# Default configuration
COPY sockd.conf /etc/

USER sockd

EXPOSE 1080

ENTRYPOINT ["dumb-init"]
CMD ["/usr/sbin/sockd"]
