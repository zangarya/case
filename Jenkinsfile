pipeline 
{
    agent any
    tools 
    {
        maven 'M3'
    }
    stages 
    {
        stage('Build Jar')
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
                }
            }
        }
        stage('Push Docker Image') 
        {
            steps 
            {
                script 
                {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker_hub_login') 
                    {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
            }
        }
        stage('Login Openshift')
        {
            steps 
            {
                script
                {
                    openshift.withCluster( 'https://192.168.99.100:8443/', 'Y4NJ45sE_GpglJkDSS1ILO9GFWkyzT9JtXrpBQUpiYw' )
                    {
                        openshift.withProject( 'jtop' ) 
                        {
                            echo "Hello from project ${openshift.project()} in cluster ${openshift.cluster()}"
                            echo "App Create:"
                            def created = openshift.newApp('eminturan/denemes:latest')
                            echo "new-app created ${created.count()} objects named: ${created.names()}"
                            created.describe()
                        }
                    }
                }
            }
        }
    }
}
