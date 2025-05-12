pipeline {
    agent any

    options {
        skipStagesAfterUnstable()
    }

    stages {
        stage('Build') {
            steps {
                dir('src') {
                    sh 'kotlinc Main.kt Animal.kt -include-runtime -d ../app.jar'
                }
            }
        }

        stage('Test') {
            steps {
                dir('test') {
                    sh 'kotlinc -cp ../app.jar AnimalTest.kt -include-runtime -d ../test.jar && java -jar ../test.jar'
                }
            }
        }

        stage('Deliver') {
            steps {
                archiveArtifacts artifacts: 'app.jar', fingerprint: true
            }
        }
    }
}
