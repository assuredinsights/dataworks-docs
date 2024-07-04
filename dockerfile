FROM maven:3.8-openjdk-17 AS build

# Install dependencies
RUN microdnf update && microdnf install -y antlr4 make jq curl

WORKDIR /app
COPY . .

# Build OpenMetadata Server Application
RUN mvn clean install -DskipTests -X -e

FROM openmetadata/server:latest

# Copy built UI files
COPY --from=build /app/openmetadata-ui /app/openmetadata-ui

# Copy custom start script if needed
# COPY --chmod=755 docker/openmetadata-start.sh /

ENTRYPOINT ["/bin/bash"]
CMD ["/openmetadata-start.sh"]