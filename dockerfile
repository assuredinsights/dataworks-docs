FROM maven:3.8-openjdk-17 AS build

# Install dependencies
RUN microdnf update && microdnf install -y make curl nodejs npm

# Install Yarn
RUN npm install -g yarn

# Install ANTLR
RUN curl -O https://www.antlr.org/download/antlr-4.9.2-complete.jar && \
    mv antlr-4.9.2-complete.jar /usr/local/lib/ && \
    echo '#!/bin/sh' > /usr/local/bin/antlr4 && \
    echo 'java -Xmx500M -cp "/usr/local/lib/antlr-4.9.2-complete.jar:$CLASSPATH" org.antlr.v4.Tool "$@"' >> /usr/local/bin/antlr4 && \
    chmod +x /usr/local/bin/antlr4

WORKDIR /app
COPY . .

# Build OpenMetadata Server Application
RUN mvn clean install -DskipTests -X -e -Dnode.version=v16.13.0 -Dnpm.version=8.1.0

# Rebuild UI separately
WORKDIR /app/openmetadata-ui/src/main/resources/ui
RUN yarn install && yarn build

FROM openmetadata/server:latest

# Copy built UI files
COPY --from=build /app/openmetadata-ui/src/main/resources/ui/build /app/openmetadata-ui/src/main/resources/ui/build

ENTRYPOINT ["/bin/bash"]
CMD ["/openmetadata-start.sh"]