FROM docker.io/node:lts-alpine
EXPOSE 30000

RUN apk add --no-cache jq curl

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD [ "curl", "--fail", "http://localhost:30000" ]

ENV FOUNDRY_FILE=foundry.zip

ENV PUID=1000
ENV PGID=1000
ENV USER=node

VOLUME [ "/storage", "/app", "/data" ]

COPY ./entrypoint.sh /entrypoint.sh
COPY ./set-up-user.sh /usr/local/bin/set-up-user.sh

ENTRYPOINT [ "/entrypoint.sh" ]
