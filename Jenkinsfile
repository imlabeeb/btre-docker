def registryCredentials1 = "nexus"
def protocol = "http://"
def registryURL1 = "192.168.1.8:8082"

pipeline {
    agent any

    parameters {
         string(name: 'ImageName', defaultValue: 'btre')
    }

    stages {

    stage('Cloning Git') {
      steps {
        git branch: 'main', credentialsId: 'github', url: 'https://github.com/imlabeeb/btre-docker.git'
      }
    }

    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build("${registryURL1}/${params.ImageName}" + ":$BUILD_NUMBER")
        }
      }
    }

    stage('Push target-image to nexus') {
        steps {
            script {
                docker.withRegistry(protocol + registryURL1, registryCredentials1) {
                  dockerImage.push()
                    
                }
            }
        }
    }

    stage('apply new image to kubernetes deployment') {
      steps{
        sh "kubectl patch deployment btre-deployment -p '{\"spec\": {\"template\": {\"spec\":{\"containers\":[{\"name\": \"btre-container\", \"image\": \"${registryURL1}/${params.ImageName}:${BUILD_NUMBER}\"}]}}}}'"
      }
    } 

    stage('Remove Unused docker image') {
      steps{
        sh "docker rmi ${registryURL1}/${params.ImageName}:${BUILD_NUMBER}"
      }
    }   

  }
}