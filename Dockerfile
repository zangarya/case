FROM openjdk:8-jre-alpine3.7

COPY target/rest-service-0.0.1-SNAPSHOT.jar rest-service.jar

EXPOSE 8080
COPY wrapper.sh /wrapper.sh

RUN chmod 555 /wrapper.sh

ENTRYPOINT ["/wrapper.sh"]
