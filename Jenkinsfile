pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'saravanan141297/focus-task:latest'
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
                    docker.build("${DOCKER_IMAGE}")
                }
            }
        }

        stage('Push Docker Image to DockerHub') {
            steps {
                echo 'Pushing image to DockerHub...'
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials') {
                        sh "docker push ${DOCKER_IMAGE}"
                    }
                }
            }
        }

        stage('Deploy to AWS EC2') {
            steps {
                echo 'Deploying to EC2...'
                sshagent(['ec2-ssh-key']) {
                    sh '''
                        ssh -o StrictHostKeyChecking=no ec2-user@52.90.29.238 '
                            docker pull ${DOCKER_IMAGE} &&
                            docker stop focus-task || true &&
                            docker rm focus-task || true &&
                            docker run -d -p 80:80 --name focus-task ${DOCKER_IMAGE}
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
        success {
            echo '✅ Deployment succeeded!'
        }
    }
}

