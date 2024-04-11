FROM node:current-alpine
EXPOSE 30000

RUN apk add --no-cache jq

ENV FOUNDRY_ZIP_DIR=/storage
ENV FOUNDRY_FILE=foundry.zip
ENV FOUNDRY_DIR=/app
ENV DATA_DIR=/data

ENV PUID=1000
ENV PGID=1000
ENV USER=node

VOLUME [ $FOUNDRY_ZIP_DIR ]
VOLUME [ $FOUNDRY_DIR ]
VOLUME [ $DATA_DIR ]

COPY ./entrypoint.sh /entrypoint.sh
COPY ./set-up-user.sh /usr/local/bin/set-up-user.sh

ENTRYPOINT [ "/entrypoint.sh" ]
