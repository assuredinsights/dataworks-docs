FROM maven:3.8-openjdk-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean install -DskipTests

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