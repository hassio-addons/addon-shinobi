#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: Shinobi
# Ensures the super user account credentials are configured
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

declare CONFIG
declare username
declare password

CONFIG=$(</opt/shinobi/super.json)
username=$(hass.config.get 'super_username')
password=$(hass.config.get 'super_password')
password=$(echo -n "${password}" | md5sum | sed -e 's/  -$//')

CONFIG=$(hass.jq "${CONFIG}" ".[0].mail=\"${username}\"")
CONFIG=$(hass.jq "${CONFIG}" ".[0].pass=\"${password}\"")

echo "${CONFIG}" > /opt/shinobi/super.json
