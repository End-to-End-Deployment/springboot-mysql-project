pipeline {
    agent any

    tools {
        maven 'mymaven'
        jdk 'myjava'
    }

    environment {
        GIT_BRANCH = 'main' // Specify the correct branch name
        // Replace 'kubeconfig-credentials-id' with your Jenkins credentials ID
        KUBECONFIG_CREDENTIALS_ID = '5169ce58-f369-4583-bc04-3892ad22ebc1'
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo 'Cloning the repository...'
                git branch: "${GIT_BRANCH}", url: 'https://github.com/Samir-Kesare/springboot-mysql-project.git'
            }
        }

        stage('Package') {
            steps {
                echo 'Building the project...'
                sh 'mvn clean install'
            }
        }

        stage('Docker Login') {
            steps {
                echo 'Logging into Docker...'
                sh 'docker login -u 7720001490 -p Snatak@2024'
            }
        }

        stage('Kubernetes Deployment') {
            steps {
                echo 'Deploying to Kubernetes...'
                withCredentials([file(credentialsId: KUBECONFIG_CREDENTIALS_ID, variable: 'KUBECONFIG')]) {
                    sh '''
                    #!/bin/bash
                    kubectl apply -f statefulsets.yaml
                    kubectl apply -f deployment.yaml
                    '''
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up...'
            cleanWs()
        }
    }
}
