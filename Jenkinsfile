pipeline {
    agent any

    environment {
        IMAGE_NAME = "digital-commerce-app"
        CONTAINER_NAME = "digital-commerce-container"
        DOCKER_IMAGE_TAG = "latest"
        SONARQUBE_ENV = "SonarQubeServer" // Must match the Jenkins configured SonarQube name
    }

    tools {
        maven 'Maven 3.8.5' // Make sure Jenkins has this configured under Global Tools
    }

    stages {
        stage('Clone Source') {
            steps {
                git credentialsId: 'github-token', url: 'https://github.com/rajeshkush30/digital-commerce.git', branch: 'master'
            }
        }
        
        stage('Code Quality - SonarQube') {
            steps {
                withSonarQubeEnv("${SONARQUBE_ENV}") {
                    withMaven(maven: 'Maven 3.8.5') {
                        // Sonar analysis with Maven plugin
                        bat 'mvn sonar:sonar -Dsonar.projectKey=digital-commerce-app -Dsonar.login=%SONAR_AUTH_TOKEN%'
                    }
                }
            }
        }

        stage('Build Project') {
            steps {
                bat 'mvn clean install -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat "docker build -t %IMAGE_NAME%:%DOCKER_IMAGE_TAG% ."
            }
        }

        stage('Stop and Remove Existing Container') {
            steps {
                bat """
                docker stop %CONTAINER_NAME% || exit 0
                docker rm %CONTAINER_NAME% || exit 0
                """
            }
        }

        stage('Run Docker Container') {
            steps {
                bat """
                docker run -d -p 8081:8081 --name %CONTAINER_NAME% %IMAGE_NAME%:%DOCKER_IMAGE_TAG%
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
