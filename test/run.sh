#! /usr/bin/env bash
docker run --rm -ti -e PUID=1234 -e PGID=1234 -p 30000:30000 -v ./data:/data -v ./app:/app -v ./FoundryVTT-11.315.zip:/storage/foundry.zip foundry