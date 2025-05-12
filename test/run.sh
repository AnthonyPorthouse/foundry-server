#! /usr/bin/env bash
podman run --rm -ti -e PUID=1234 -e PGID=1234 -p 30000:30000 -v ./data:/data -v ./app:/app -v ./FoundryVTT-Node-13.342.zip:/storage/foundry.zip foundry
