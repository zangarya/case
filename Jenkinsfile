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
                    openshift.withCluster('https://192.168.99.100:8443/', 'eyJhbGciOiJSUzI1NiIsImtpZCI6IiJ9.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJqdG9wIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6ImplbmtpbnMtdG9rZW4td2h2aGoiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoiamVua2lucyIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6ImQ1MTk0M2NkLWU2YmQtMTFlYS04MTE5LTA4MDAyNzhjYTc3MCIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDpqdG9wOmplbmtpbnMifQ.Rif3swEctoXyMJHAUQ__RWLSOuUHGGoStmLHNIi7sFZHkZhyi017GXy3Ot_E2u1Cae4QT-DSPhniw55zSR0H0lK4wt8ugge9BBQzbIXtO3u1oURvRRKPph2s1N7BlkvE4yTR5awbTZf4bH0vINpw3mXYM97AWz5FjHZRez4WX7slZrxqINNxScDIjI1Zlqv9azSa4DsSrtezvWM0EgplMpH3nh0kZ7iXlK3PJYdyzgfCoYMahgOSPgDGoQUonrP4q3W8E3Prn1r1IirQGw1lWs9AXKj9XA5D73mBJrGuZw1ye_lhCmOSD4a1kk_-diOUyqTL-Dn6nVqOaaYo3dRPwg')
                    {
                        openshift.withProject( 'jtop' ) 
                        {
                            echo "Hello from project ${openshift.project()} in cluster ${openshift.cluster()}"
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
