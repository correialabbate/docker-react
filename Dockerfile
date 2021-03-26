# builder phase
FROM node:alpine as builder

USER node

RUN mkdir -p /home/node/app
WORKDIR '/home/node/app'

COPY --chown=node:node ./package.json ./
RUN npm install

COPY --chown=node:node ./ ./

RUN npm run build
# files generated from the build command -> $(WORKDIR)/build

# run phase
FROM nginx

COPY --from=builder /home/node/app/build /usr/share/nginx/html

# default command of this image is to run nginx