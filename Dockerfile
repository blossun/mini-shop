FROM ubuntu:18.04

LABEL maintainer="blossunn@gmail.com"

# packages install
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y sudo vim net-tools ssh openssh-server openjdk-8-jdk

# java 환경변수
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

WORKDIR /usr/ubuntu
COPY . .

RUN chmod +x ./gradlew
RUN ./gradlew build -x test

ARG JAR_FILE=./build/libs/mini-shop-0.0.1-SNAPSHOT.jar
RUN cp ${JAR_FILE} mini-shop.jar

ENTRYPOINT ["java","-jar","mini-shop.jar"]
