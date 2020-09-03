#!/bin/bash

exec /usr/bin/xpra start --daemon=no --start-child="$@"
