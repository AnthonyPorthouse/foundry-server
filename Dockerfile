FROM node:lts-alpine
EXPOSE 30000
# EXPOSE 30000/udp

RUN apk add --no-cache jq

ENV FOUNDRY_FILE=foundry.zip

ENV PUID=1000
ENV PGID=1000
ENV USER=node

VOLUME [ "/storage", "/app", "/data" ]

COPY ./entrypoint.sh /entrypoint.sh
COPY ./set-up-user.sh /usr/local/bin/set-up-user.sh

ENTRYPOINT [ "/entrypoint.sh" ]
