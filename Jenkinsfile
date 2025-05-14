pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                echo 'Compilando el proyecto con Maven...'
                sh 'mvn compile'
            }
        }

        stage('Run Main') {
            steps {
                echo 'Ejecutando Main.kt...'
                sh 'mvn exec:java -Dexec.mainClass=Main'
            }
        }

        stage('Run Tests') {
            steps {
                echo 'Ejecutando tests con Maven...'
                sh 'mvn test'
            }
        }
    }

    post {
        always {
            junit '**/target/surefire-reports/*.xml'
        }
        success {
            echo 'Pipeline completado correctamente.'
        }
        failure {
            echo 'Error en la ejecución del pipeline.'
        }
    }
}
