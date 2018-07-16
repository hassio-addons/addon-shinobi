ARG BUILD_FROM=hassioaddons/base-amd64:2.0.1
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Setup base
# hadolint ignore=DL3003
RUN \
    apk add --no-cache --virtual .build-dependencies \
        git=2.18.0-r0 \
        g++=6.4.0-r8 \
        make=4.2.1-r2 \
        build-base=0.5-r1 \
        openssl-dev=1.0.2o-r1 \
        python2-dev=2.7.15-r0 \
        jpeg-dev=8-r6 \
        pkgconf=1.5.1-r0 \
        yarn=1.7.0-r0 \
    \
    && apk add --no-cache \
        nodejs=8.11.3-r2 \
        ffmpeg=3.4.2-r2 \
        python2=2.7.15-r0 \
        sqlite=3.24.0-r0 \
        socat=1.7.3.2-r4 \
        ttf-freefont=20120503-r1 \
        mysql-client=10.2.15-r0 \
        x264=20180304-r1 \
        x265=2.7-r1 \
    \
    && git clone -b master --single-branch \
        https://gitlab.com/Shinobi-Systems/Shinobi.git /opt/shinobi/ \
    && git -C /opt/shinobi checkout 80260b0798f973c79e7f2b0a48afd969fec580f2 \
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
