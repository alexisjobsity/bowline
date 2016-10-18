FROM alpine:3.4

RUN apk add --no-cache dropbear openssh rsync bash

# Unison build code copied from https://github.com/cweagans/docker-bg-sync

# Install Unison from source with inotify support + remove compilation tools
ARG UNISON_VERSION=2.48.4
RUN apk add --no-cache --virtual .build-dependencies build-base curl && \
    apk add --no-cache inotify-tools && \
    apk add --no-cache --repository http://dl-4.alpinelinux.org/alpine/edge/testing/ ocaml && \
    curl -L https://github.com/bcpierce00/unison/archive/$UNISON_VERSION.tar.gz | tar zxv -C /tmp && \
    cd /tmp/unison-${UNISON_VERSION} && \
    sed -i -e 's/GLIBC_SUPPORT_INOTIFY 0/GLIBC_SUPPORT_INOTIFY 1/' src/fsmonitor/linux/inotify_stubs.c && \
    make UISTYLE=text NATIVE=true STATIC=true && \
    cp src/unison src/unison-fsmonitor /usr/bin && \
    apk del .build-dependencies ocaml && \
    rm -rf /tmp/unison-${UNISON_VERSION}

# Prepare dropbear
RUN mkdir /etc/dropbear && touch /var/log/lastlog

# Copy the bg-sync script into the container.
COPY sync.sh /usr/bin/bg-sync
RUN chmod +x /usr/bin/bg-sync

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["dropbear", "-RFEm", "-p", "22"]
