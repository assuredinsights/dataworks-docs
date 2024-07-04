FROM maven:3.8-openjdk-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean install -DskipTests

FROM openmetadata/server:latest
COPY --from=build /app/openmetadata-ui /app/openmetadata-ui
ENTRYPOINT ["/bin/bash"]
CMD ["/openmetadata-start.sh"]