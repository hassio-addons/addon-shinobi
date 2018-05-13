ARG BUILD_FROM=hassioaddons/base-amd64:1.4.1
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Setup base
# hadolint ignore=DL3003
RUN \
    apk add --no-cache --virtual .build-dependencies \
        git=2.15.0-r1 \
        g++=6.4.0-r5 \
        make=4.2.1-r0 \
        build-base=0.5-r0 \
        openssl-dev=1.0.2o-r0 \
        python2-dev=2.7.14-r2 \
        jpeg-dev=8-r6 \
        pkgconf=1.3.10-r0 \
        yarn=1.3.2-r0 \
    \
    && apk add --no-cache \
        nodejs=8.9.3-r1 \
        ffmpeg=3.4-r1 \
        python2=2.7.14-r2 \
        sqlite=3.21.0-r0 \
        socat=1.7.3.2-r3 \
        ttf-freefont=20120503-r0 \
        mysql-client=10.1.32-r0 \
        x264=20170930-r0 \
        x265=2.5-r0 \
    \
    && git clone -b dev --single-branch --depth 1 \
        https://github.com/ShinobiCCTV/Shinobi.git /opt/shinobi/ \
    && git -C /opt/shinobi checkout 2bc74064da5484545d86fce9cf95db74ace0db48 \
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
