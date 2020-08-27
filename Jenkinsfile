pipeline 
{
    agent any
    environment {
        DOCKER_IMAGE_NAME = "eminturan/denemes"
    }
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
            steps 
            {
                script 
                {
                    app = docker.build(DOCKER_IMAGE_NAME) 
                }
            }
        }
        stage('Push Nexus Image') 
        {
            steps 
            {
                script 
                {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker_hub_login') 
                    {
                        sh 'docker tag eminturan/denemes:latest localhost:8123/' + DOCKER_IMAGE_NAME + ':' + env.BUILD_NUMBER
                        sh 'docker login -u admin -p admin localhost:8123'
                        sh 'docker push localhost:8123/' + DOCKER_IMAGE_NAME + ':' + env.BUILD_NUMBER
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
                sh 'oc new-app localhost:8123/' + DOCKER_IMAGE_NAME + ':' + env.BUILD_NUMBER + ' --name=denemes'
                sh 'oc expose service denemes'
            }
        }
    }
}
