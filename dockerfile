FROM docker.getcollate.io/openmetadata/server:1.4.1

USER root

RUN apk add --no-cache git nodejs npm

WORKDIR /tmp
RUN git clone https://github.com/assuredinsights/dataworks-docs.git

WORKDIR /tmp/dataworks-docs
RUN npm install && npm run build

RUN rm -rf /opt/openmetadata/webapp/*
COPY --chown=openmetadata:openmetadata /tmp/dataworks-docs/build/ /opt/openmetadata/webapp/

RUN rm -rf /tmp/dataworks-docs
RUN apk del git nodejs npm

USER openmetadata

ENTRYPOINT ["/bin/bash"]
CMD ["/openmetadata-start.sh"]