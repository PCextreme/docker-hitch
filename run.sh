#!/bin/sh
set -e

exec hitch --pidfile=/run/hitch.pid --user ${HITCH_USER} --group ${HITCH_GROUP} --workers=${HITCH_WORKERS} --config ${HITCH_CONFIG}
