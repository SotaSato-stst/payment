FROM node:16-alpine
WORKDIR /app
COPY package* ./
RUN npm install --production
COPY index.js resolver.js schema.js ./
COPY datasource/ ./datasource/
COPY proto/ ./proto/
EXPOSE 4000
CMD [ "node", "index.js" ]
