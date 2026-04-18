#!/bin/sh
set -e

mkdir -p /factorio/config
envsubst < /templates/server-settings.json.tmpl > /factorio/config/server-settings.json

exec /docker-entrypoint.sh "$@"
