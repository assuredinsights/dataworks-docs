FROM ubuntu:latest AS build

# Install dependencies
RUN apt-get update && apt-get install -y \
    openjdk-17-jdk maven jq make curl nodejs npm

# Install Yarn
RUN npm install -g yarn

# Install ANTLR
RUN curl -O https://www.antlr.org/download/antlr-4.9.2-complete.jar && \
    mv antlr-4.9.2-complete.jar /usr/local/lib/ && \
    echo 'alias antlr4="java -Xmx500M -cp /usr/local/lib/antlr-4.9.2-complete.jar org.antlr.v4.Tool"' >> ~/.bashrc && \
    echo 'export PATH="/usr/local/lib:$PATH"' >> ~/.bashrc && \
    . ~/.bashrc

WORKDIR /app
COPY . .

# Build OpenMetadata Server Application
RUN mvn -DskipTests clean package

FROM alpine:3.19 AS extract
COPY --from=build /app/openmetadata-dist/target/openmetadata-*.tar.gz /
RUN mkdir -p /opt/openmetadata && \
    tar zxvf openmetadata-*.tar.gz -C /opt/openmetadata --strip-components 1 && \
    rm openmetadata-*.tar.gz

FROM alpine:3.19
EXPOSE 8585
RUN adduser -D openmetadata && \
    apk update && \
    apk upgrade && \
    apk add --update --no-cache bash openjdk17-jre
COPY --chown=openmetadata:openmetadata --from=extract /opt/openmetadata /opt/openmetadata
COPY --chmod=755 docker/openmetadata-start.sh /
USER openmetadata
WORKDIR /opt/openmetadata
ENTRYPOINT ["/bin/bash"]
CMD ["/openmetadata-start.sh"]