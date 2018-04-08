#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: Shinobi
# Ensures the database structure is loaded into MySQL
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

declare host
declare username
declare password
declare database
declare port
declare numberOfTables

if hass.config.true 'mysql'; then
    host=$(hass.config.get 'mysql_host')
    username=$(hass.config.get 'mysql_username')
    password=$(hass.config.get 'mysql_password')
    database=$(hass.config.get 'mysql_database')
    port=$(hass.config.get 'mysql_port')

    numberOfTables=$(
        mysql -h "${host}" -u "${username}" -p"${password}" -P ${port} \
            "${database}" -N -B -e "show tables;" | wc -l
    )

    if [[ "${numberOfTables}" -eq 0 ]]; then
        mysql -h "${host}" -u "${username}" -p"${password}" -P ${port} \
            "${database}" < "/opt/shinobi/sql/tables.sql" ||
                hass.die "Error while importing database table structure!"
    fi
fi
