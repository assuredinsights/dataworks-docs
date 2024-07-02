FROM docker.getcollate.io/openmetadata/server:1.4.1

USER root

RUN apk add --no-cache git nodejs npm

WORKDIR /tmp
RUN git clone https://github.com/assuredinsights/dataworks-docs.git

WORKDIR /tmp/dataworks-docs

# Remove yarn dependency
RUN sed -i 's/"preinstall": "yarn global add node-gyp"//' package.json

RUN npm install
RUN npm install -g node-gyp
RUN npm run build

RUN rm -rf /opt/openmetadata/webapp/*
RUN cp -R /tmp/dataworks-docs/build/* /opt/openmetadata/webapp/

RUN rm -rf /tmp/dataworks-docs
RUN apk del git nodejs npm

USER openmetadata

ENTRYPOINT ["/bin/bash"]
CMD ["/openmetadata-start.sh"]