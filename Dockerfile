FROM node:16

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN npm install
# Bundle app source
COPY . .

RUN chmod +x entrypoint.sh

EXPOSE 8080 51005 80 443

ENTRYPOINT ["/bin/bash", "entrypoint.sh"]
