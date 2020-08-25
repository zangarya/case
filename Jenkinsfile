pipeline 
{
    agent any
    stages 
    {
        stage('compile') 
        {
            steps 
            {
                sh 'mvn clean install'
            }
        }
        stage('build')
        {
            steps
            {
                sh 'echo hello world'
            }
        }
    }
}
