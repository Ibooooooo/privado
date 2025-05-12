pipeline {
    agent any

    environment {
        KOTLIN_HOME = '/opt/kotlinc'
        JUNIT_CP = '/opt/junit/junit-jupiter-api-5.7.0.jar:/opt/junit/junit-jupiter-engine-5.7.0.jar:/opt/junit/junit-platform-launcher-1.7.0.jar'
    }

    stages {
        stage('Compilar app') {
            steps {
                sh '''
                    mkdir -p build
                    ${KOTLIN_HOME}/bin/kotlinc src/*.kt -include-runtime -d build/app.jar
                '''
            }
        }

        stage('Compilar tests') {
            steps {
                sh '''
                    ${KOTLIN_HOME}/bin/kotlinc -cp "build/app.jar:${JUNIT_CP}" test/*.kt -include-runtime -d build/test.jar
                '''
            }
        }

        stage('Ejecutar tests') {
            steps {
                sh '''
                    ${KOTLIN_HOME}/bin/kotlin -cp "build/test.jar:build/app.jar:${JUNIT_CP}" \
                    org.junit.platform.console.ConsoleLauncher --select-class AnimalTest
                '''
            }
        }
    }
}
