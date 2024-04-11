#!/usr/bin/env sh
set -e

# Username/Groupname to use
USER=$1

# Target User ID
PUID=$2

# Target Group ID
PGID=$3

if [ ! "$(id -u "${USER}")" -eq "$PUID" ] || [ ! "$(id -g "${USER}")" -eq "$PGID" ]; then
    deluser --remove-home "${USER}"
    addgroup -S "${USER}" -g "${PGID}"
    adduser -S -s /bin/ash -G "${USER}" -u "${PUID}" "${USER}"
fi

echo "
-----------------------------------
GID/UID
-----------------------------------
User uid:    $(id -u "${USER}")
User gid:    $(id -g "${USER}")
-----------------------------------
"