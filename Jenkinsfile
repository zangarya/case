pipeline 
{
    agent any
    tools 
    {
        maven 'M3'
    }
    stages 
    {
        stage('build')
        {
            steps 
            {
                sh '''
                 mvn clean package
                 cd target
                 cp rest-service-0.0.1-SNAPSHOT.jar rest-service.jar 
                '''
                stash includes: 'target/*.jar', name: 'targetfiles'
            }
        }
        stage('Build Docker Image') 
        {
            steps {
                script {
                    app = docker.build("eminturan/denemes")
                    app.inside {
                        sh 'echo Emin, Turan'
                    }
                }
            }
        }
    }
}
