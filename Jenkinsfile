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
                        pp.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
            }
        }
        stage('Deploy Openshift')
        {
            steps 
            {
                sh 'oc login -u admin -p admin https://192.168.99.100:8443 --insecure-skip-tls-verify=true'
                sh 'oc project jtop'
                sh 'oc delete route denemes'
                sh 'oc delete service denemes'
                sh 'oc delete dc denemes'
                sh 'oc new-app eminturan/denemes:latest --name denemes'
                sh 'oc expose service denemes'
            }
        }
    }
}
