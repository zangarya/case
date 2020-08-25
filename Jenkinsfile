pipeline 
{
  agent 
  {
    dockerfile 
    {
      filename 'Dockerfile'
    } 
  }
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
        echo 'Running build automation'
        sh 'mvn clean install'
        archiveArtifacts artifacts: 'xx/xxxx.zip'
      }
    }
  }
}
