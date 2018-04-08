#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: Shinobi
# Ensures the db settings are configured
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

declare CONFIG
declare host
declare username
declare password
declare database
declare port

CONFIG=$(</opt/shinobi/conf.json)
CONFIG=$(hass.jq "${CONFIG}" ".db={}")

if hass.config.true 'mysql'; then
    CONFIG=$(hass.jq "${CONFIG}" ".databaseType=\"mysql\"")

    host=$(hass.config.get 'mysql_host')
    CONFIG=$(hass.jq "${CONFIG}" ".db.host=\"${host}\"")
    
    username=$(hass.config.get 'mysql_username')
    CONFIG=$(hass.jq "${CONFIG}" ".db.user=\"${username}\"")

    password=$(hass.config.get 'mysql_password')
    CONFIG=$(hass.jq "${CONFIG}" ".db.password=\"${password}\"")

    database=$(hass.config.get 'mysql_database')
    CONFIG=$(hass.jq "${CONFIG}" ".db.database=\"${database}\"")

    port=$(hass.config.get 'mysql_port')
    CONFIG=$(hass.jq "${CONFIG}" ".db.port=\"${port}\"")
else
    CONFIG=$(hass.jq "${CONFIG}" ".databaseType=\"sqlite3\"")
    CONFIG=$(hass.jq "${CONFIG}" ".db.filename=\"/data/shinobi.sqlite\"")
fi

echo "${CONFIG}" > /opt/shinobi/conf.json
