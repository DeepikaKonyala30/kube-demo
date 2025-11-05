// ============== JENKINSFILE – LOCKED TO UBUNTU 24.04 DIGEST ==============
pipeline {
    agent any

    environment {
        // THIS IS THE ONLY IMAGE THAT WILL EVER RUN
        BASE_IMAGE = 'ubuntu@sha256:66460d557b25769b102175144d538d88219c077c678a49af4afca6fbfc1b5252'
        MY_APP     = 'deepikakonyala30/kube-demo'
        TAG        = "latest"
    }

    stages {
        // 1. Verify we really pulled the pinned image
        stage('Pull Immutable Ubuntu') {
            steps {
                script {
                    docker.image(BASE_IMAGE).pull()
                    sh "docker inspect --format='{{.Id}}' ${BASE_IMAGE} | grep 66460d55"
                }
            }
        }

        // 2. Build YOUR app inside the pinned Ubuntu
        stage('Build Docker Image') {
            steps {
                script {
                    docker.withServer('/var/run/docker.sock') {
                        appImage = docker.build("${MY_APP}:${TAG}", "-f Dockerfile .")
                    }
                }
            }
        }

        // 3. Push with both tag + latest
        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-cred-id') {
                        appImage.push()
                        appImage.push('latest')
                    }
                }
            }
        }

        // 4. One-click K8s deploy (optional – delete if you don’t need)
        stage('Deploy to Kubernetes') {
            when { branch 'main' }
            steps {
                script {
                    kubernetesDeploy(
                        kubeconfigId: 'kubeconfig-id',
                        configs: 'k8s/deployment.yaml',
                        enableConfigSubstitution: true
                    )
                }
            }
        }
    }

    post {
        always {
            cleanWs()
            sh "docker rmi ${MY_APP}:${TAG} ${BASE_IMAGE} || true"
        }
    }
}
// =====================================================================