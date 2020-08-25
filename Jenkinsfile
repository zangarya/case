pipeline 
{
    agent any
    stages 
    {
        stage('Build Jar')
        {
            steps 
            {
                sh 'mvn package'
                stash includes: 'target/*.jar', name: 'targetfiles'
            }
        }   
    }
}
