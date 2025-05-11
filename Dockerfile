# Imagen base estable de Jenkins LTS
FROM jenkins/jenkins:lts

USER root

# Instalación de Docker CLI, Git y utilidades necesarias
RUN apt-get update && \
    apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg \
        git \
        unzip \
        bash-completion \
        lsb-release \
        software-properties-common && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && \
    apt-get install -y docker-ce-cli

# Instalar Ruby
RUN apt-get install -y ruby-full

# Verificar instalación
RUN ruby --version && gem --version

# Crear directorio para pruebas
RUN mkdir -p /var/jenkins_home/test_project

# Instalar plugins de Jenkins
COPY Jenkins/plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt

# Volver al usuario Jenkins
USER jenkins
