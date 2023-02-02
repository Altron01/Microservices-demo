pipeline {
  agent {
    node {
      label 'jenkins-slave'
    }

  }
  stages {
    stage('error') {
      steps {
        sh '''cd ./Microservices-demo/apps/entry-api
npm install'''
      }
    }

  }
}