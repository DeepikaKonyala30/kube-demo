pipeline {
    agent any
    environment {
        BASE_IMAGE = 'ubuntu@sha256:66460d557b25769b102175144d538d88219c077c678a49af4afca6fbfc1b5252'
        APP_IMAGE  = 'deepzz72206/kube-demo'   // ← your DockerHub user
        TAG        = "${env.BUILD_NUMBER}"
    }
    stages {
        stage('Wait for Docker') {
            steps { bat '''
                @echo off
                :loop
                docker info >nul 2>&1
                if %errorlevel%==0 goto done
                echo Docker not ready, sleep 5s...
                timeout /t 5 >nul
                goto loop
                :done
                echo Docker is READY!
            ''' }
        }
        stage('Pull Locked Ubuntu') {
            steps {
                script { docker.image(BASE_IMAGE).pull() }
                bat "docker inspect --format={{.Id}} %BASE_IMAGE% | findstr 66460d55"
            }
        }
        stage('Build Node App') {
            steps {
                script {
                    def img = docker.build("${APP_IMAGE}:${TAG}", '.')
                    img.inside { bat 'node -v && npm -v' }
                }
            }
        }
        stage('Push') {
            steps {
                script {
                    docker.withRegistry('', 'dockerhub-cred-id') {
                        docker.image("${APP_IMAGE}:${TAG}").push()
                        docker.image("${APP_IMAGE}:${TAG}").push('latest')
                    }
                }
            }
        }
    }
    post { always { cleanWs() } }
}
