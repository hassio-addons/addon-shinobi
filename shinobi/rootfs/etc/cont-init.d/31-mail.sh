#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: Shinobi
# Ensures the mail settings and credentials are configured
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

declare CONFIG
declare service
declare username
declare password
declare host
declare port

CONFIG=$(</opt/shinobi/conf.json)

service=$(hass.config.get 'mail_service')
username=$(hass.config.get 'mail_username')
password=$(hass.config.get 'mail_password')

CONFIG=$(hass.jq "${CONFIG}" ".mail={\"auth\": {}}");

if [[ "${service}" = "gmail" ]]; then
    CONFIG=$(hass.jq "${CONFIG}" ".mail.service=\"gmail\"")
else
    host=$(hass.config.get 'mail_host')
    CONFIG=$(hass.jq "${CONFIG}" ".mail.host=\"${host}\"")
    
    port=$(hass.config.get 'mail_port')
    CONFIG=$(hass.jq "${CONFIG}" ".mail.port=${port}")

    if hass.config.true 'mail_secure'; then
        CONFIG=$(hass.jq "${CONFIG}" ".mail.secure=true")
    else
        CONFIG=$(hass.jq "${CONFIG}" ".mail.secure=false")
    fi

    if hass.config.false 'mail_cert_verify'; then
        CONFIG=$(hass.jq "${CONFIG}" ".mail.tls={\"rejectUnauthorized\": false}")
    fi
fi

CONFIG=$(hass.jq "${CONFIG}" ".mail.auth.user=\"${username}\"")
CONFIG=$(hass.jq "${CONFIG}" ".mail.auth.pass=\"${password}\"")

echo "${CONFIG}" > /opt/shinobi/conf.json