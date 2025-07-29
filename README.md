[![Update Latest Release](https://github.com/AnthonyPorthouse/foundry-server/actions/workflows/update-latest-release.yml/badge.svg)](https://github.com/AnthonyPorthouse/foundry-server/actions/workflows/update-latest-release.yml)

# Foundry Server

## Which Version do I Need?

Foundry offers different versions of their software for download.

To use this container, we want to use the `Node.js` release.

## Example Usage

A working example can be found below:

```yaml
# compose.yaml
services:
  foundry:
    image: ghcr.io/anthonyporthouse/docker-foundry:2
    restart: unless-stopped
    hostname: foundry
    
    ports:
      - 80:30000

    environment:
      PUID: 1000
      PGID: 1000
      FOUNDRY_FILE: 'FoundryVTT-Node-13.346.zip'

    volumes:
      - ./data:/data
      - ./app:/app
      - ./storage:/storage:ro
```

## Paths

- `/storage` -- This is where you store your Foundry VTT zip files.
- `/app` -- This is where the Foundry VTT application gets stored when loaded. It is used to validate when the application needs to be updated.
- `/data` -- This is where your user data goes. Configuration, Worlds, Systems and Modules get stored in here.

## Environment Variables

- `FOUNDRY_FILE` -- The name of the Foundry zip to load from the `/storage` directory. Typically, updated when a new release zip is downloaded.
- `PUID` -- The User ID to run the process as. Typically, this wants to be the same as the current user, which can be checked with `id -u`
- `PGID` -- The Group ID to run the process as. Typically, this wants to be the same as the current user, which can be checked with `id -g`
- `USER` -- The name of the user to run the process as. This defaults to `node` and it is usually fine to leave this.
