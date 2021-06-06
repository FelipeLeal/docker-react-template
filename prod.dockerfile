FROM node:alpine3.11 as build

RUN npm install -g npm@7.15.1

ENV CONTAINER_DIR=/app
ENV HOST_DIR=./react

WORKDIR $CONTAINER_DIR

# add `/react/node_modules/.bin` to $PATH
ENV PATH $CONTAINER_DIR/node_modules/.bin:$PATH

COPY package*.json $CONTAINER_DIR

COPY $HOST_DIR $CONTAINER_DIR

RUN yarn && \
    yarn build


FROM nginx:1.19.0-alpine

ENV CONTAINER_DIR=/app
ENV HOST_DIR=./react

COPY --from=build $CONTAINER_DIR/build /etc/nginx/html
# --------- only for those using react router ----------
# if you are using react router
# you need to overwrite the default nginx configurations
# remove default nginx configuration file
RUN rm /etc/nginx/conf.d/default.conf
# replace with custom one
COPY --chown=nginx:nginx $HOST_DIR/nginx/nginx.conf /etc/nginx/conf.d/default.conf
# --------- /only for those using react router ----------

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]