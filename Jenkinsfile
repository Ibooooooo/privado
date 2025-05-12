pipeline {
    agent any

    environment {
        KOTLIN_HOME = '/opt/kotlinc'
        JUNIT_LIB = '/opt/junit'
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
                    ${KOTLIN_HOME}/bin/kotlinc -cp "build/app.jar:${JUNIT_LIB}/*" test/*.kt -include-runtime -d build/test.jar
                '''
            }
        }

        stage('Ejecutar tests') {
            steps {
                sh '''
                    ${KOTLIN_HOME}/bin/kotlin -cp "build/test.jar:build/app.jar:${JUNIT_LIB}/*" \
                    org.junit.platform.console.ConsoleLauncher --select-class AnimalTest
                '''
            }
        }
    }
}
