pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                docker build --no-cache -t hello_django:${currentBuild.number}
            }
        }
        stage('tag') {
            steps {
                docker tag hello_django:${currentBuild.number} nexus.dev.scrapehero.com/hello-django:${currentBuild.number}
            }
        }
        stage('push') {
            steps {
                docker push nexus.dev.scrapehero.com/hello-django:${currentBuild.number}
            }
        }
    }
}