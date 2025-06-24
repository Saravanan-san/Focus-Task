pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'saravanan141297/focus-task'
        DOCKERHUB_CREDENTIALS_ID = 'dockerhub-credentials-id'
        EC2_SSH_CREDENTIALS_ID = 'ec2-ssh-key-id'
        EC2_HOST = 'ec2-user@52.90.29.238'
    }

    stages {
        stage('Clone Repo') {
            steps {
                echo 'Cloning repository...'
                git branch: 'main', url: 'https://github.com/Saravanan-san/Focus-Task.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                script {
                    docker.build("${DOCKER_IMAGE}:latest")
                }
            }
        }

        stage('Push Docker Image to DockerHub') {
            steps {
                echo 'Pushing image to DockerHub...'
                script {
                    docker.withRegistry('https://index.docker.io/v1/', "${DOCKERHUB_CREDENTIALS_ID}") {
                        docker.image("${DOCKER_IMAGE}:latest").push()
                    }
                }
            }
        }

        stage('Deploy to AWS EC2') {
            steps {
                echo 'Deploying to EC2...'
                sshagent (credentials: [EC2_SSH_CREDENTIALS_ID]) {
                    sh """
                        ssh -o StrictHostKeyChecking=no ${EC2_HOST} '
                          docker pull ${DOCKER_IMAGE}:latest &&
                          docker stop focus-task || true &&
                          docker rm focus-task || true &&
                          docker run -d -p 80:80 --name focus-task ${DOCKER_IMAGE}:latest
                        '
                    """
                }
            }
        }
    }

    post {
        success {
            echo '✅ Deployment successful!'
        }
        failure {
            echo '❌ Deployment failed!'
        }
    }
}

