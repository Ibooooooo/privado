FROM jenkins/jenkins:lts

USER root

RUN apt-get update && apt-get install -y \
    git \
    maven \
    unzip \
    curl \
    gnupg \
    lsb-release \
    ca-certificates

# Instalar Kotlin
RUN curl -sSLO https://github.com/JetBrains/kotlin/releases/download/v1.9.24/kotlin-compiler-1.9.24.zip && \
    unzip kotlin-compiler-1.9.24.zip -d /opt && \
    ln -s /opt/kotlin-compiler-1.9.24/bin/kotlinc /usr/local/bin/kotlinc

# Plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt --verbose

USER jenkins
