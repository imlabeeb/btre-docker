def registryCredentials1 = "nexus"
// def registryCredentials2 = "docker"
def protocol = "http://"
def registryURL1 = "localhost:8082"
// def registryURL2= "harbor.mycompany.xx.yy.com"

pipeline {
    agent any

    parameters {
        //  string(name: 'sourceImageName', defaultValue: '', description: 'Source-Image-Name, name-schema is like user/foo, e.g. jenkins/jenkins')
        //  string(name: 'sourceImageTag', defaultValue: '', description: 'Source-Image-Tag, e.g. lts')
        //  string(name: 'targetImageName', defaultValue: '', description: 'Target-Image-Name, name-schema is like user/foo, e.g. jenkins/jenkins')
        //  string(name: 'targetImageTag', defaultValue: '', description: 'Target-Image-Tag, e.g. lts')
         string(name: 'ImageName', defaultValue: 'btre')
    }

    stages {

        // stage('Pull source-image from Registry 1 & tag the image') {
        //     steps {
        //         script {
        //             //pull source-image from registry 1
        //             docker.withRegistry(protocol + registryURL1, registryCredentials1) {
        //                 docker.image("${params.sourceImageName}:${params.sourceImageTag}").pull()
        //             }

        //             //tag the image
        //             sh "docker tag ${registryURL1}/${params.sourceImageName}:${params.sourceImageTag} ${registryURL2}/${params.targetImageName}:${params.targetImageTag}"
        //         }
        //     }
        // }

    stage('Cloning Git') {
      steps {
        git branch: 'main', credentialsId: 'github', url: 'https://github.com/imlabeeb/btre-docker.git'
      }
    }

    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build(${registryURL1}/${params.ImageName} + ":$BUILD_NUMBER")
        }
      }
    }

    stage('Push target-image to nexus') {
        steps {
            script {
                //push target-image to registry 2
                docker.withRegistry(protocol + registryURL1, registryCredentials1) {
                    // sh "docker push ${registryURL1}/${params.ImageName}:${params.ImageTag}"
                  dockerImage.push()
                    
                }
            }
        }
    }
    stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $registry:$BUILD_NUMBER"
      }
    }    
  }
}