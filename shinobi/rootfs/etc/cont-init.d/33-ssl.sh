#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: Shinobi
# Ensures the SSL settings are configured
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

declare CONFIG
declare certfile
declare keyfile

CONFIG=$(</opt/shinobi/conf.json)

if hass.config.true 'ssl'; then
    CONFIG=$(hass.jq "${CONFIG}" ".ssl={}")

    certfile=$(hass.config.get 'certfile')
    CONFIG=$(hass.jq "${CONFIG}" ".ssl.cert=\"/ssl/${certfile}\"")

    keyfile=$(hass.config.get 'keyfile')
    CONFIG=$(hass.jq "${CONFIG}" ".ssl.key=\"/ssl/${keyfile}\"")
else
    CONFIG=$(hass.jq "${CONFIG}" "del(.ssl)")
fi

echo "${CONFIG}" > /opt/shinobi/conf.json
