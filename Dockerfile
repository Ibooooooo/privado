FROM jenkins/jenkins:lts

# Permite el uso de sudo dentro del contenedor
USER root

# Instala dependencias básicas, Docker CLI y Kotlin Compiler
RUN apt-get update && apt-get install -y \
    sudo \
    curl \
    unzip \
    git \
    docker.io \
    && curl -LO https://github.com/JetBrains/kotlin/releases/download/v1.9.22/kotlin-compiler-1.9.22.zip \
    && unzip kotlin-compiler-1.9.22.zip \
    && mv kotlinc /opt/kotlinc \
    && ln -s /opt/kotlinc/bin/kotlinc /usr/local/bin/kotlinc \
    && ln -s /opt/kotlinc/bin/kotlin /usr/local/bin/kotlin \
    && rm kotlin-compiler-1.9.22.zip \
    && apt-get clean

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
