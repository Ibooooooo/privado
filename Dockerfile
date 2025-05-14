FROM jenkins/jenkins:lts

USER root

# -------------------------------
# Dependencias básicas
# -------------------------------
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    lsb-release \
    ca-certificates \
    unzip \
    software-properties-common

# -------------------------------
# Instalar Docker CLI
# -------------------------------
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list && \
    apt-get update && \
    apt-get install -y docker-ce-cli

# -------------------------------
# Instalar Maven
# -------------------------------
ENV MAVEN_VERSION=3.9.6
RUN curl -fsSL https://downloads.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz | tar -xz -C /opt/ && \
    ln -s /opt/apache-maven-${MAVEN_VERSION}/bin/mvn /usr/bin/mvn

# -------------------------------
# Instalar Kotlin
# -------------------------------
ENV KOTLIN_VERSION=1.9.24
RUN curl -sSLO https://github.com/JetBrains/kotlin/releases/download/v${KOTLIN_VERSION}/kotlin-compiler-${KOTLIN_VERSION}.zip && \
    unzip kotlin-compiler-${KOTLIN_VERSION}.zip -d /opt && \
    ln -s /opt/kotlinc/bin/kotlinc /usr/bin/kotlinc && \
    ln -s /opt/kotlinc/bin/kotlin /usr/bin/kotlin && \
    rm kotlin-compiler-${KOTLIN_VERSION}.zip

# -------------------------------
# Instalar plugins con jenkins-plugin-cli (viene preinstalado)
# -------------------------------
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt

USER jenkins
