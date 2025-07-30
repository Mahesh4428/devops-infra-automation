pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-creds')
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Mahesh4428/devops-infra-automation.git'
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve'
            }
        }

        stage('Ansible - Jenkins Setup') {
            steps {
                sh 'ansible-playbook -i ansible/hosts.cfg ansible/jenkins.yml'
            }
        }

        stage('Ansible - K8s Setup') {
            steps {
                sh 'ansible-playbook -i ansible/hosts.cfg ansible/k8s.yml'
            }
        }
    }

    post {
        success {
            echo 'Infrastructure and Configuration completed successfully.'
        }
        failure {
            echo 'Something went wrong in one of the stages.'
        }
    }
}

