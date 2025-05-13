# Etapa 1: Build de la app y ejecución de tests
FROM maven:3.9.6-eclipse-temurin-21 AS builder
WORKDIR /app
COPY pom.xml .
COPY app/src ./src
RUN mvn clean verify

# Etapa 2: Contenedor final que ejecuta la app
FROM eclipse-temurin:21-jdk
WORKDIR /app
COPY --from=builder /app/target/redsocial-0.0.1-SNAPSHOT.jar app.jar

# Ejecutar la aplicación Spring Boot
ENTRYPOINT ["java", "-jar", "app.jar"]
