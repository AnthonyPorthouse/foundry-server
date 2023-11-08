FROM node:current-alpine
EXPOSE 30000

RUN apk add --no-cache jq

ENV FOUNDRY_ZIP_DIR=/storage
ENV FOUNDRY_FILE=foundry.zip
ENV FOUNDRY_DIR=/app
ENV DATA_DIR=/data

VOLUME [ $FOUNDRY_ZIP_DIR ]
VOLUME [ $FOUNDRY_DIR ]
VOLUME [ $DATA_DIR ]

COPY ./entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]

CMD ["sh", "-c", "node ${FOUNDRY_DIR}/main.js --dataPath=${DATA_DIR}"]
