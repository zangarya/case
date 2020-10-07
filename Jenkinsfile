pipeline 
{
    agent any
    environment {
        DOCKER_IMAGE_NAME = "zangarya/test"
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
                        /*sh 'docker tag eminturan/denemes:latest localhost:8083/' + DOCKER_IMAGE_NAME + ':' + env.BUILD_NUMBER
                        sh 'docker login -u admin -p admin localhost:8083'
                        sh 'docker push localhost:8083/' + DOCKER_IMAGE_NAME + ':' + env.BUILD_NUMBER*/
                        
                        //sh 'docker tag denemes localhost:8083/' + DOCKER_IMAGE_NAME + ':' + env.BUILD_NUMBER
                        //sh 'docker push localhost:8083/' + DOCKER_IMAGE_NAME + ':' + env.BUILD_NUMBER
                        app.push("latest")
                    }
                }
            }
        }
        stage('DeployToProduction') {
            when {
                branch 'master'
            }
            steps {
                input 'Deploy to Production?'
                milestone(1)
                kubernetesDeploy(
                    kubeconfigId: 'kubeconfig',
                    configs: 'msrest.yml',
                    enableConfigSubstitution: true
                )
            }
        }
        /*
        stage('Deploy Openshift')
        {
            steps 
            {
                sh 'oc login -u admin -p admin https://192.168.99.101:8443 --insecure-skip-tls-verify=true'
                
                
                sh 'oc project denemes-project'
                sh 'oc import-image eminturan/denemes:latest --confirm'
                
            }
        } */
    }
}
