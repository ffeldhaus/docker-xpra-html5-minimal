#!/bin/bash

# configure dbus
dbus-uuidgen > /var/lib/dbus/machine-id
mkdir -p /var/run/dbus
dbus-daemon --config-file=/usr/share/dbus-1/system.conf --print-address

exec /usr/bin/xpra start --daemon=no --start-child="$@"
