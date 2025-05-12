pipeline {
    agent any

    options {
        skipStagesAfterUnstable()
    }

    stages {
        stage('Build') {
            steps {
                dir('kotlin/src') {
                    sh 'kotlinc Main.kt Animal.kt -include-runtime -d ../app.jar'
                }
            }
        }

        stage('Test') {
            steps {
                dir('kotlin/test') {
                    sh 'kotlinc -cp ../app.jar AnimalTest.kt -include-runtime -d test.jar && java -jar test.jar'
                }
            }
        }

        stage('Deliver') {
            steps {
                archiveArtifacts artifacts: 'kotlin/app.jar', fingerprint: true
            }
        }
    }
}
