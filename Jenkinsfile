pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building...'
            }
        }

        stage('Test') {
            steps {
                echo 'Testing...'
            }
        }
		
		stage('SonarQube Analysis') {
			steps {
				withSonarQubeEnv('SonarQubeServer') {
					sh 'mvn sonar:sonar -Dsonar.projectKey=digital-commerce -Dsonar.host.url=http://localhost:9000'
				}
			}
		}
		
		environment {
			IMAGE_NAME = 'your-dockerhub-username/your-app'
		}

        stage('Build App') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${IMAGE_NAME}")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh """
                        echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                        docker push ${IMAGE_NAME}
                    """
                }
            }
        }
    

        stage('Deploy') {
            steps {
                echo 'Deploying...'
            }
        }
    }
}
