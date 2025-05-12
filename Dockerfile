FROM jenkins/jenkins:lts

# Permite el uso de sudo dentro del contenedor
USER root

# Instala dependencias básicas, Docker CLI, Kotlin Compiler, SDKMAN y JUnit
RUN apt-get update && apt-get install -y \
    sudo \
    curl \
    unzip \
    git \
    docker.io \
    wget \
    && curl -s https://get.sdkman.io | bash \
    && bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && sdk install kotlin" \
    && curl -LO https://github.com/JetBrains/kotlin/releases/download/v1.9.22/kotlin-compiler-1.9.22.zip \
    && unzip kotlin-compiler-1.9.22.zip \
    && mv kotlinc /opt/kotlinc \
    && ln -s /opt/kotlinc/bin/kotlinc /usr/local/bin/kotlinc \
    && ln -s /opt/kotlinc/bin/kotlin /usr/local/bin/kotlin \
    && rm kotlin-compiler-1.9.22.zip \
    && mkdir -p /opt/junit \
    && curl -L -o /opt/junit/junit-jupiter-api-5.7.0.jar https://repo1.maven.org/maven2/org/junit/jupiter/junit-jupiter-api/5.7.0/junit-jupiter-api-5.7.0.jar \
    && curl -L -o /opt/junit/junit-jupiter-engine-5.7.0.jar https://repo1.maven.org/maven2/org/junit/jupiter/junit-jupiter-engine/5.7.0/junit-jupiter-engine-5.7.0.jar \
    && curl -L -o /opt/junit/junit-platform-launcher-1.7.0.jar https://repo1.maven.org/maven2/org/junit/platform/junit-platform-launcher/1.7.0/junit-platform-launcher-1.7.0.jar \
    && apt-get clean

# Da permisos a Jenkins para usar Docker
RUN usermod -aG docker jenkins

# Instala plugins de Jenkins en el arranque
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
RUN jenkins-plugin-cli --plugins \
    blueocean \
    docker-workflow \
    git

# Volver al usuario Jenkins (por seguridad)
USER jenkins

# Crea el directorio de trabajo
WORKDIR /app

# Expone los puertos de Jenkins
EXPOSE 8080
EXPOSE 50000
