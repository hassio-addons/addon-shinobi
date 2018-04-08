ARG BUILD_FROM=hassioaddons/base-amd64:1.3.3
FROM ${BUILD_FROM}

# Setup base
RUN \
    apk add --no-cache --virtual .build-dependencies \
        git \
        g++ \
        make \
        build-base \
        openssl-dev \
        python-dev \
        jpeg-dev \
        pkgconfig \
        yarn \
    \
    && apk add --no-cache \
        nodejs \
        ffmpeg \
        python \
        sqlite \
        socat \
        ttf-freefont \
        mysql-client \
        x264 \
        x265 \
    \
    && git clone -b dev --single-branch --depth 1 \
        https://github.com/ShinobiCCTV/Shinobi.git /opt/shinobi/ \
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
    org.label-schema.url="https://community.home-assistant.io/t/community-hass-io-add-on-shinobi/41261?u=frenck" \
    org.label-schema.usage="https://github.com/hassio-addons/addon-shinobi/tree/master/README.md" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/hassio-addons/addon-shinobi" \
    org.label-schema.vendor="Community Hass.io Add-ons"
