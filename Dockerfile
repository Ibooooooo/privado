FROM maven:3.9.6-eclipse-temurin-21 AS builder
WORKDIR /app

COPY pom.xml .
COPY app/src ./src

RUN mvn clean package -DskipTests

FROM eclipse-temurin:21-jdk
WORKDIR /app
COPY --from=builder /app/target/redsocial-0.0.1-SNAPSHOT.jar app.jar

ENTRYPOINT ["java", "-cp", "app.jar", "com.darkcode.spring.app.AppApplication"]
