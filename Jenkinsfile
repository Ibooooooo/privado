pipeline {
  agent any

  environment {
    DART_HOME = "/usr/lib/dart/bin"
    PATH = "${env.PATH}:${env.DART_HOME}"
  }

  stages {
    stage('Preparar entorno') {
      steps {
        sh '''
          dart --version
          echo "name: herencia_dart" > pubspec.yaml
        '''
      }
    }

    stage('Instalar dependencias') {
      steps {
        sh 'dart pub get'
      }
    }

    stage('Analizar código') {
      steps {
        sh 'dart analyze lib/'
      }
    }

    stage('Ejecutar tests') {
      steps {
        sh 'dart test test/test.dart'
      }
    }

    stage('Empaquetar') {
      steps {
        sh 'tar -czvf personaje_package.tar.gz lib/ test/ pubspec.yaml'
        archiveArtifacts artifacts: 'personaje_package.tar.gz', fingerprint: true
      }
    }
  }

  post {
    always {
      echo "Pipeline finalizado."
    }
    success {
      echo "✅ Éxito total: Build, test y empaquetado."
    }
    failure {
      echo "❌ Algo falló."
    }
  }
}
