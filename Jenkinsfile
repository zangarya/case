pipeline 
{
    agent any
    stages 
    {
        stage('build')
        {
            steps
            {
                sh 'make' 
                archiveArtifacts artifacts: '**/target/*.jar', fingerprint: true
            }
        }
    }
}
