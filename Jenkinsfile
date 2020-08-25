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
                    openshift.withCluster('https://192.168.99.100:8443/', 'f7CQD0ugxUl3UH2HPf3uQOtpZtrxzwemw5L4xxbfOv0')
                    {
                        openshift.withProject( 'jtop' ) 
                        {
                            echo "Hello from project ${openshift.project()} in cluster ${openshift.cluster()}"
                            echo "1"
                        }
                        def saSelector = openshift.selector( 'serviceaccount' )
                        saSelector.describe()
                        saSelector.withEach 
                        {
                            echo "Service account: ${it.name()} is defined in ${openshift.project()}"
                        }
                        echo "There are ${saSelector.count()} service accounts in project ${openshift.project()}"
                        echo "They are named: ${saSelector.names()}"
                    }
                }
            }
        }
    }
}
