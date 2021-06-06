#FROM reactbase_react:latest

FROM node:alpine3.11

RUN npm install -g npm@7.15.1

ENV CONTAINER_DIR=/app
ENV HOST_DIR=./react

WORKDIR $CONTAINER_DIR

# add `/react/node_modules/.bin` to $PATH
ENV PATH $CONTAINER_DIR/node_modules/.bin:$PATH

# COPY before install fora docker cache
COPY $HOST_DIR/package*.json $CONTAINER_DIR

RUN npm install

COPY $HOST_DIR/ $CONTAINER_DIR

RUN CI=true npm test && \
    npm run build