pipeline {
    agent any

    environment {
        IMAGE_NAME = 'saravanan141297/focus-task:latest'
    }

    stages {
        stage('Clone Repo') {
            steps {
                echo 'Cloning repository...'
                git 'https://github.com/Saravanan-san/Focus-Task.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                script {
                    docker.build("${IMAGE_NAME}")
                }
            }
        }

        stage('Push Docker Image to DockerHub') {
            steps {
                echo 'Pushing image to DockerHub...'
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub') {
                        sh "docker tag ${IMAGE_NAME} index.docker.io/${IMAGE_NAME}"
                        sh "docker push index.docker.io/${IMAGE_NAME}"
                    }
                }
            }
        }

        stage('Deploy to AWS EC2') {
            steps {
                echo 'Deploying to EC2...'
                sshagent (credentials: ['ubuntu']) {
                    sh '''
                        ssh -o StrictHostKeyChecking=no ubuntu@52.90.29.238 '
                            docker pull saravanan141297/focus-task:latest &&
                            docker stop focus-task || true &&
                            docker rm focus-task || true &&
                            docker run -d -p 80:80 --name focus-task saravanan141297/focus-task:latest
                        '
                    '''
                }
            }
        }
    }

    post {
        failure {
            echo '❌ Deployment failed!'
        }
    }
}

