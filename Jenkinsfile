pipeline {
    agent any

    environment {
        AWS_REGION = 'ap-south-1'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Mahesh4428/devops-infra-automation.git'
            }
        }

        stage('Terraform Init') {
            environment {
                TF_IN_AUTOMATION = "1"
            }
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
                                  credentialsId: 'aws-creds',
                                  accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                                  secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                    dir('terraform') {
                        sh 'terraform init'
                    }
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
                                  credentialsId: 'aws-creds',
                                  accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                                  secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                    dir('terraform') {
                        sh 'terraform apply -auto-approve'
                    }
                }
            }
        }

        stage('Ansible - Jenkins Setup') {
            steps {
                sh '''
                    ansible-playbook -i inventory.ini ansible/jenkins-setup.yml
                '''
            }
        }

        stage('Ansible - K8s Setup') {
            steps {
                sh '''
                    ansible-playbook -i inventory.ini ansible/k8s-setup.yml
                '''
            }
        }
    }
}

