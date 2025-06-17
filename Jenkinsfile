pipeline {
    agent any

    environment {
        IMAGE_NAME = "digital-commerce-app"
        CONTAINER_NAME = "digital-commerce-container"
        DOCKER_IMAGE_TAG = "latest"
    }

    tools {
        maven 'Maven 3.8.5' // Make sure Jenkins has this configured under Global Tools
    }

    stages {
        stage('Clone Source') {
            steps {
                git credentialsId: 'github-creds', url: 'https://github.com/rajeshkush30/digital-commerce.git', branch: 'master'
            }
        }

        stage('Build Project') {
            steps {
                sh 'mvn clean install -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:${DOCKER_IMAGE_TAG} ."
            }
        }

        stage('Stop and Remove Existing Container') {
            steps {
                sh """
                docker stop ${CONTAINER_NAME} || true
                docker rm ${CONTAINER_NAME} || true
                """
            }
        }

        stage('Run Docker Container') {
            steps {
                sh """
                docker run -d -p 8080:8080 --name ${CONTAINER_NAME} ${IMAGE_NAME}:${DOCKER_IMAGE_TAG}
                """
            }
        }
    }

    post {
        success {
            echo '✅ Deployment Successful!'
        }
        failure {
            echo '❌ Deployment Failed. Please check the console output.'
        }
    }
}
