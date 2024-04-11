#! /usr/bin/env sh

FOUNDRY_ZIP_DIR=${FOUNDRY_ZIP_DIR:-/storage}
FOUNDRY_FILE=${FOUNDRY_FILE:-foundry.zip}
FOUNDRY_DIR=${FOUNDRY_DIR:-/app}
DATA_DIR=${DATA_DIR:-/data}

PUID=${PUID:-1000}
PGID=${PGID:-1000}
USER=${USER:-"node"}

set-up-user.sh "$USER" "$PUID" "$PGID"

set_permissions() {
    chown -R "${USER}":"${USER}" "${FOUNDRY_DIR}"
    chown -R "${USER}":"${USER}" "${DATA_DIR}"
}

main() {

    foundryzip="$FOUNDRY_ZIP_DIR/$FOUNDRY_FILE"

    # Check file existance
    if [ ! -f "$foundryzip" ]; then
        echo "No such file $foundryzip" > /dev/stderr
        exit 1
    fi

    # Check file contains Foundry
    if ! unzip -qq -l "$foundryzip" foundryvtt > /dev/null 2>&1 ; then
        echo "Not a valid Foundry VTT zip file" > /dev/stderr
        exit 1
    fi

    if [ -f "$FOUNDRY_DIR/package.json" ]; then

        current_version=$(jq -c .version < "$FOUNDRY_DIR/package.json")
        new_version=$(unzip -qq -p "$foundryzip" resources/app/package.json | jq -c .version)
        
        if [ "$current_version" = "$new_version" ]; then
            echo "Version already matches, not updating"
            return
        fi

        rm -r "${FOUNDRY_DIR:?}"/* "${FOUNDRY_DIR:?}"/.*
    fi

    tmpdir=$(mktemp -d)

    # Replace resources directory
    unzip -qq "$foundryzip" resources/app/** -d "$tmpdir"

    cp -r "$tmpdir/resources/app"/* /app

    rm -rf "$tmpdir"
}

main

set_permissions

COMMAND="${*:-"node ${FOUNDRY_DIR}/main.js --dataPath=${DATA_DIR}"}"

su -l "${USER}" -c "$COMMAND"