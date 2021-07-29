def registryCredentials1 = "nexus"
def protocol = "http://"
def registryURL1 = "192.168.1.8:8082"

pipeline {
    agent any

    parameters {
        //  string(name: 'sourceImageName', defaultValue: '', description: 'Source-Image-Name, name-schema is like user/foo, e.g. jenkins/jenkins')
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

    // stage('Building image') {
    //   steps{
    //     script {
    //       dockerImage = docker.build("${registryURL1}/${params.ImageName}" + ":$BUILD_NUMBER")
    //     }
    //   }
    // }

    // stage('Push target-image to nexus') {
    //     steps {
    //         script {
    //             //push target-image to nexus
    //             docker.withRegistry(protocol + registryURL1, registryCredentials1) {
    //                 // sh "docker push ${registryURL1}/${params.ImageName}:${params.ImageTag}"
    //               dockerImage.push()
                    
    //             }
    //         }
    //     }
    // }

    stage('apply new image to kubernetes deployment') {
      steps{
        sh "kubectl patch deployment btre-deployment -p {$(cat patch-file.yaml)}"
      }
    } 

    // stage('Remove Unused docker image') {
    //   steps{
    //     sh "docker rmi ${registryURL1}/${params.ImageName}:${BUILD_NUMBER}"
    //   }
    // }    
  }
}