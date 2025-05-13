# Imagen base con Java 21
FROM openjdk:21-jdk-alpine

# Variable para el jar
ARG JAR_FILE=target/redsocial-0.0.1-SNAPSHOT.jar

# Copiar el JAR al contenedor
COPY ${JAR_FILE} app.jar

# Exponer el puerto 8080
EXPOSE 8080

# Ejecutar el JAR
ENTRYPOINT ["java", "-jar", "/app.jar"]