pipeline {
    agent any
    options {
        skipStagesAfterUnstable()
    }
    stages {
        stage('Build') {
            steps {
                echo 'No build step needed for Ruby'
            }
        }
        stage('Test') {
            steps {
                dir('code') {
                    sh 'ruby TestGestorBD.rb'
                }
            }
        }
        stage('Deliver') {
            steps {
                archiveArtifacts artifacts: 'code/GestorBD.rb', fingerprint: true
            }
        }
    }
}
