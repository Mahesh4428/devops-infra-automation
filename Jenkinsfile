pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

    stages {
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

        stage('Ansible Provision') {
            steps {
                dir('ansible') {
                    sh 'ansible-playbook -i hosts.cfg jenkins.yml'
                }
            }
        }
    }

    post {
        success {
            echo '✅ Infrastructure provisioned and configured successfully!'
        }
        failure {
            echo '❌ Pipeline failed. Please check logs for details.'
        }
    }
}

