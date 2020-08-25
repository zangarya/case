pipeline 
{
    agent any
    stages 
    {
        stage('build')
        {
            steps 
            {
                sh '''
                 mvn clean package
                 cd target
                 cp todo-app-java-on-azure-1.0-SNAPSHOT.jar msrest.jar 
                 zip msrest.zip app.jar web.config
                '''
                stash includes: 'target/*.jar', name: 'targetfiles'
            }
        }   
    }
}
