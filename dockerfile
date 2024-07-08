# Stage 1: Build OpenMetadata Server Application
FROM ubuntu:latest AS build

# Install dependencies
RUN apt-get update && apt-get install -y \
    openjdk-17-jdk \
    maven \
    curl \
    make \
    jq \
    nodejs \
    npm

# Install Yarn globally
RUN npm install -g yarn

# Install ANTLR CLI
RUN curl -O https://www.antlr.org/download/antlr-4.9.2-complete.jar && \
    mv antlr-4.9.2-complete.jar /usr/local/lib/ && \
    echo '#!/bin/sh' > /usr/local/bin/antlr4 && \
    echo 'java -Xmx500M -cp "/usr/local/lib/antlr-4.9.2-complete.jar:$CLASSPATH" org.antlr.v4.Tool "$@"' >> /usr/local/bin/antlr4 && \
    chmod +x /usr/local/bin/antlr4

# Set the working directory
WORKDIR /app

# Copy the project files into the container
COPY . .

# Build OpenMetadata Server Application with Maven
RUN mvn clean package -DskipTests

# Stage 2: Create the final Docker image to run OpenMetadata Server
FROM ubuntu:latest

# Install necessary runtime dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    bash \
    openjdk-17-jre-headless

# Expose the relevant port
EXPOSE 8585

# Create a non-root user
RUN useradd -ms /bin/bash openmetadata

# Copy the build output from the build stage
COPY --from=build /app/openmetadata-dist/target/*.tar.gz /opt/openmetadata/

# Extract the tar.gz file into /opt/openmetadata
RUN mkdir -p /opt/openmetadata && \
    tar zxvf /opt/openmetadata/*.tar.gz -C /opt/openmetadata --strip-components 1 && \
    rm /opt/openmetadata/*.tar.gz && \
    chown -R openmetadata:openmetadata /opt/openmetadata

# Ensure the start.sh script has execute permissions
RUN chmod +x /opt/openmetadata/bin/start.sh

# Switch to non-root user
USER openmetadata

# Set the working directory
WORKDIR /opt/openmetadata

# Set entrypoint and command
ENTRYPOINT ["/bin/bash"]
CMD ["/opt/openmetadata/bin/start.sh"]
