pipeline {
  agent {
    dockerfile {
      filename 'Dockerfile'
    }
    
  }
  stages {
    stage('compile') {
      steps {
        sh 'mvn clean install'
      }
    }
  }
}
