#!/bin/bash

# configure dbus
dbus-uuidgen > /var/lib/dbus/machine-id
mkdir -p /var/run/dbus
dbus-daemon --config-file=/usr/share/dbus-1/system.conf --print-address

# start xpra as xpra user with command specified in dockerfile as CMD or passed as parameter to docker run
runuser -l xpra -c '/usr/bin/xpra start --daemon=no --start-child="$@"'