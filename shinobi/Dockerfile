ARG BUILD_FROM=hassioaddons/base:2.3.0
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Setup base
# hadolint ignore=DL3003
RUN \
    apk add --no-cache --virtual .build-dependencies \
        git=2.18.0-r0 \
        g++=6.4.0-r9 \
        make=4.2.1-r2 \
        build-base=0.5-r1 \
        openssl-dev=1.0.2p-r0 \
        python2-dev=2.7.15-r1 \
        jpeg-dev=8-r6 \
        pkgconf=1.5.3-r0 \
        yarn=1.7.0-r0 \
    \
    && apk add --no-cache \
        nodejs=8.11.4-r0 \
        ffmpeg=3.4.4-r1 \
        python2=2.7.15-r1 \
        sqlite=3.24.0-r0 \
        socat=1.7.3.2-r4 \
        ttf-freefont=20120503-r1 \
        mysql-client=10.1.32-r0 \
        x264=20170930-r0 \
        x265=2.5-r0 \
    \
    && git clone -b master --single-branch \
        https://github.com/ShinobiCCTV/Shinobi.git /opt/shinobi/ \
    && git -C /opt/shinobi checkout 4d00c910f756167e8b04bd4a3795c2ffda3e823c \
    && git -C /opt/shinobi reflog expire --expire=now --all \
    && git -C /opt/shinobi gc --prune=now --aggressive \
    \
    && cd /opt/shinobi \
    && yarn add mysql sqlite3 \
    && yarn install \
    && apk del --purge .build-dependencies

# Copy root filesystem
COPY rootfs /

# Build arugments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="Shinobi" \
    io.hass.description="Beautiful and feature-rich CCTV/NVR for your camera's" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Franck Nijhof <frenck@addons.community>" \
    org.label-schema.description="Beautiful and feature-rich CCTV/NVR for your camera's" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="Shinobi" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="https://community.home-assistant.io/t/community-hass-io-add-on-shinobi-pro/49767?u=frenck" \
    org.label-schema.usage="https://github.com/hassio-addons/addon-shinobi/tree/master/README.md" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/hassio-addons/addon-shinobi" \
    org.label-schema.vendor="Community Hass.io Add-ons"
