FROM gradle:jdk8 as builder

COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle build

FROM openjdk:8-jre-slim
EXPOSE 8080
COPY --from=builder /home/gradle/src/sagan-client/build/distributions/sagan-client.tar /app/
WORKDIR /app
RUN tar -xvf sagan-client.tar
WORKDIR /app/sagan-client
CMD bin/sagan-client