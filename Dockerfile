FROM satantime/puppeteer-node:16-bullseye-slim

ARG TARGETPLATFORM
ARG BUILDPLATFORM

RUN ARCH=${TARGETPLATFORM#linux/} && echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM, ARCH=$ARCH"

# for arm64 support we need to install chromium provided by debian
# npm ERR! The chromium binary is not available for arm64.
# https://github.com/puppeteer/puppeteer/issues/7740
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

RUN ARCH=${TARGETPLATFORM#linux/} && apt-get update \
    && apt-get install -yq libxslt1.1 \
    && wget https://snapshot.debian.org/archive/debian-security/20220722T181415Z/pool/updates/main/c/chromium/chromium-common_103.0.5060.134-1~deb11u1_$ARCH.deb \
    && apt install -fy chromium-common_*.deb \
    && rm -f chromium-common_*.deb \
    && wget https://snapshot.debian.org/archive/debian-security/20220722T181415Z/pool/updates/main/c/chromium/chromium_103.0.5060.134-1~deb11u1_$ARCH.deb \
    && apt install -fy chromium_*.deb \
    && rm -f chromium_*.deb \
    && apt-get clean
