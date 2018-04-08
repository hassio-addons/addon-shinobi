#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: Shinobi
# Created a symlink of the persistent stored config to the location Shinobi
# expects it to be.
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

ln -s /data/conf.json /opt/shinobi/conf.json
ln -s /data/super.json /opt/shinobi/super.json
