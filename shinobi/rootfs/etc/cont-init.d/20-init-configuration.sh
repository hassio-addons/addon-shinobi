#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: Shinobi
# Creates initial Shinobi configuration in case it is non-existing
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

declare CONFIG

if ! hass.directory_exists '/share/shinobi'; then
    mkdir '/share/shinobi'
fi

if ! hass.file_exists '/data/shinobi.sqlite'; then
    cp /opt/shinobi/sql/shinobi.sample.sqlite /data/shinobi.sqlite
fi

if ! hass.file_exists '/data/conf.json'; then
    CONFIG=$(</opt/shinobi/conf.sample.json)

    CONFIG=$(hass.jq "${CONFIG}" ".cpuUsageMarker=\"cpu\"")
    CONFIG=$(hass.jq "${CONFIG}" ".port=80")
    CONFIG=$(hass.jq "${CONFIG}" ".videosDir=\"/share/shinobi/\"")

    echo "${CONFIG}" > /data/conf.json
fi

if ! hass.file_exists '/data/super.json'; then
    cp /opt/shinobi/super.sample.json /data/super.json
fi

if ! hass.file_exists '/data/motion.conf.json'; then
    cp /opt/shinobi/plugins/motion/conf.sample.json /data/motion.conf.json
fi
