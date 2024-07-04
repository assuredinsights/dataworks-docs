FROM maven:3.8-openjdk-17 AS build

# Install dependencies
RUN microdnf update && microdnf install -y make curl nodejs npm

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
RUN mvn clean install -DskipTests -X -e

FROM openmetadata/server:latest

# Copy built UI files
COPY --from=build /app/openmetadata-ui /app/openmetadata-ui

ENTRYPOINT ["/bin/bash"]
CMD ["/openmetadata-start.sh"]