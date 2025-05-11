pipeline {
    agent any
    options {
        skipStagesAfterUnstable()
    }
    stages {
        stage('Construcción') {
            steps {
                echo 'No build step needed for Ruby'
            }
        }
        stage('Ejecutar Main') {
            steps {
                dir('code') {
                    sh 'rm -f BD.txt'
                    sh 'ruby Main.rb'
                }
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
