
# Base
FROM offtechnologies/docker-arm32v6-base-image-alpine-qemu:latest

ARG UNBOUND_VERSION=1.6.7

# https://pgp.mit.edu/pks/lookup?search=0x7E045F8D&fingerprint=on&op=index
# pub  4096R/7E045F8D 2011-04-21 W.C.A. Wijngaards <wouter@nlnetlabs.nl>
ARG GPG_SHORTID="0x7E045F8D"
ARG GPG_FINGERPRINT="EDFA A3F2 CA4E 6EB0 5681  AF8E 9F6F 1C2D 7E04 5F8D"
ARG SHA256_HASH="4e7bd43d827004c6d51bef73adf941798e4588bdb40de5e79d89034d69751c9f"

ENV UID=991 GID=991

RUN echo "@community https://nl.alpinelinux.org/alpine/v3.6/community" >> /etc/apk/repositories \
 && apk -U upgrade \
 && apk add -t build-dependencies \
    gnupg \
    linux-headers \
    build-base \
    libevent-dev \
    openssl-dev \
    expat-dev \
    ca-certificates \
 && apk add \
    ldns \
    ldns-tools \
    libevent \
    openssl \
    expat \
    tini@community \
 && cd /tmp \
 && wget -q https://unbound.net/downloads/unbound-${UNBOUND_VERSION}.tar.gz \
 && wget -q https://unbound.net/downloads/unbound-${UNBOUND_VERSION}.tar.gz.asc \
 && echo "Verifying both integrity and authenticity of unbound-${NSD_VERSION}.tar.gz..." \
 && CHECKSUM=$(sha256sum unbound-${UNBOUND_VERSION}.tar.gz | awk '{print $1}') \
 && if [ "${CHECKSUM}" != "${SHA256_HASH}" ]; then echo "Warning! Checksum does not match!" && exit 1; fi \
 && gpg --keyserver pgp.mit.edu --recv-keys ${GPG_SHORTID} || \
    gpg --keyserver keyserver.pgp.com --recv-keys ${GPG_SHORTID} || \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys ${GPG_SHORTID} \
 && FINGERPRINT="$(LANG=C gpg --verify unbound-${UNBOUND_VERSION}.tar.gz.asc unbound-${UNBOUND_VERSION}.tar.gz 2>&1 \
  | sed -n "s#Primary key fingerprint: \(.*\)#\1#p")" \
 && if [ -z "${FINGERPRINT}" ]; then echo "Warning! Invalid GPG signature!" && exit 1; fi \
 && if [ "${FINGERPRINT}" != "${GPG_FINGERPRINT}" ]; then echo "Warning! Wrong GPG fingerprint!" && exit 1; fi \
 && echo "All seems good, now unpacking unbound-${UNBOUND_VERSION}.tar.gz..." \
 && tar xzf unbound-${UNBOUND_VERSION}.tar.gz && cd unbound-${UNBOUND_VERSION} \
 && ./configure \
    CFLAGS="-O2 -flto -fPIE -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 -fstack-protector-strong -Wformat -Werror=format-security" \
    LDFLAGS="-Wl,-z,now -Wl,-z,relro" \
 && NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) \
 && make -j${NPROC} && make install \
 && apk del build-dependencies \
 && rm -rf /var/cache/apk/* /tmp/* /root/.gnupg

COPY run.sh /usr/local/bin/run.sh

RUN chmod +x /usr/local/bin/*

EXPOSE 53 53/udp

CMD ["run.sh"]
