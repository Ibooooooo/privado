FROM jenkins/jenkins:lts

# Permite el uso de sudo dentro del contenedor
USER root

# Instala dependencias básicas, Docker CLI, Kotlin Compiler y JUnit
RUN apt-get update && apt-get install -y \
    sudo \
    curl \
    unzip \
    git \
    docker.io \
    wget \
    && curl -LO https://github.com/JetBrains/kotlin/releases/download/v1.9.22/kotlin-compiler-1.9.22.zip \
    && unzip kotlin-compiler-1.9.22.zip \
    && mv kotlinc /opt/kotlinc \
    && ln -s /opt/kotlinc/bin/kotlinc /usr/local/bin/kotlinc \
    && ln -s /opt/kotlinc/bin/kotlin /usr/local/bin/kotlin \
    && rm kotlin-compiler-1.9.22.zip \
    && apt-get clean

# Crear el directorio para JUnit
RUN mkdir -p /opt/junit

# Descargar JUnit 5
RUN wget -L -O /opt/junit/junit-jupiter-api-5.7.0.jar https://repo1.maven.org/maven2/org/junit/jupiter/junit-jupiter-api/5.7.0/junit-jupiter-api-5.7.0.jar \
    && wget -L -O /opt/junit/junit-jupiter-engine-5.7.0.jar https://repo1.maven.org/maven2/org/junit/jupiter/junit-jupiter-engine/5.7.0/junit-jupiter-engine-5.7.0.jar \
    && wget -L -O /opt/junit/junit-platform-launcher-1.7.0.jar https://repo1.maven.org/maven2/org/junit/platform/junit-platform-launcher/1.7.0/junit-platform-launcher-1.7.0.jar

# Da permisos a Jenkins para usar Docker
RUN usermod -aG docker jenkins

# Volver al usuario Jenkins (por seguridad)
USER jenkins

# Instala plugins de Jenkins en el arranque
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
RUN jenkins-plugin-cli --plugins \
    blueocean \
    docker-workflow \
    git
