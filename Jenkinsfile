pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the image (name it however you like)
                    dockerImage = docker.build("my-kube1:latest")
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'deepzz72206/qwerty123') {
                        dockerImage.push('latest')
                    }
                }
            }
        }
    }
}

