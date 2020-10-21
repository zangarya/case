FROM openjdk:8-jre-alpine3.7

# Install docker-compose
RUN curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose \ 
&& chmod +x /usr/local/bin/docker-compose

COPY target/rest-service-0.0.1-SNAPSHOT.jar rest-service.jar

EXPOSE 8080
COPY wrapper.sh /wrapper.sh

RUN chmod 555 /wrapper.sh

ENTRYPOINT ["/wrapper.sh"]
