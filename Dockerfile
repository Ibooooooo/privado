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
    && apt-get clean

# Instala SDKMAN y Kotlin
RUN curl -s https://get.sdkman.io | bash && \
    echo "source \$HOME/.sdkman/bin/sdkman-init.sh" >> ~/.bashrc && \
    source ~/.bashrc && \
    sdk install kotlin

# Instala JUnit 5 y lo coloca en /opt/junit
RUN mkdir -p /opt/junit && \
    curl -L -o /opt/junit/junit-jupiter-api-5.7.0.jar https://repo1.maven.org/maven2/org/junit/jupiter/junit-jupiter-api/5.7.0/junit-jupiter-api-5.7.0.jar && \
    curl -L -o /opt/junit/junit-jupiter-engine-5.7.0.jar https://repo1.maven.org/maven2/org/junit/jupiter/junit-jupiter-engine/5.7.0/junit-jupiter-engine-5.7.0.jar && \
    curl -L -o /opt/junit/junit-platform-launcher-1.7.0.jar https://repo1.maven.org/maven2/org/junit/platform/junit-platform-launcher/1.7.0/junit-platform-launcher-1.7.0.jar

# Instala los plugins de Jenkins
RUN jenkins-plugin-cli --plugins \
    blueocean \
    docker-workflow \
    git

# Da permisos a Jenkins para usar Docker
RUN usermod -aG docker jenkins

# Crea el directorio de trabajo
WORKDIR /app

# Da permisos de ejecución
RUN chmod +x /opt/kotlinc/bin/kotlinc && \
    ln -s /opt/kotlinc/bin/kotlinc /usr/local/bin/kotlinc && \
    ln -s /opt/kotlinc/bin/kotlin /usr/local/bin/kotlin

# Exponemos los puertos para Jenkins
EXPOSE 8080
EXPOSE 50000

# Vuelve a cambiar el usuario a Jenkins (por seguridad)
USER jenkins
