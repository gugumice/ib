#!/bin/sh
export INFOBEAMER_AUDIO_TARGET=hdmi
export INFOBEAMER_ADDR=0
export INFOBEAMER_LOG_LEVEL=1
export INFOBEAMER_WATCHDOG=30
exec /opt/info-beamer-pi/info-beamer /srv/smb/green/
