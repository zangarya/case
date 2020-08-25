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
        stage('Deploy Openshift')
        {
            steps 
            {
                script
                {
                    openshift.withCluster('https://127.0.0.1:8443/', 'openshift_login')
                    {
                        openshift.withProject( 'jtop' ) 
                        {
                            echo "Hello from project ${openshift.project()} in cluster ${openshift.cluster()}"
                            def created = openshift.newApp('eminturan/denemes')
                            echo "new-app created ${created.count()} objects named: ${created.names()}" 
                        }
                    }
                }
            }
        }
    }
}
