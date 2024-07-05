# Build stage
FROM alpine:3.19 AS build

COPY openmetadata-dist/target/openmetadata-*.tar.gz /

RUN mkdir -p /opt/openmetadata && \
    tar zxvf openmetadata-*.tar.gz -C /opt/openmetadata --strip-components 1 && \
    rm openmetadata-*.tar.gz

# Final stage
FROM alpine:3.19

EXPOSE 8585

RUN adduser -D openmetadata && \
    apk update && \
    apk upgrade && \
    apk add --update --no-cache bash openjdk17-jre

COPY --chown=openmetadata:openmetadata --from=build /opt/openmetadata /opt/openmetadata
COPY --chmod=755 docker/openmetadata-start.sh /

USER openmetadata

WORKDIR /opt/openmetadata
ENTRYPOINT [ "/bin/bash" ]
CMD ["/openmetadata-start.sh"]