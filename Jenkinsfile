pipeline {
    agent any

    environment {
        // These must match what you have in Jenkins > Manage Credentials
        AWS_ACCESS_KEY_ID     = credentials('aws-creds').get('key')
        AWS_SECRET_ACCESS_KEY = credentials('aws-creds').get('secret')
    }

    stages {
        stage('Checkout Repo') {
            steps {
                git branch: 'main', url: 'https://github.com/Mahesh4428/devops-intern-assignment.git'
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

        stage('Ansible Setup') {
            steps {
                sh 'ansible-playbook -i inventory.ini setup.yml || true' // This allows it to fail without killing pipeline
            }
        }
    }

    post {
        failure {
            echo '🚨 Pipeline failed. Check the logs.'
        }
        success {
            echo '✅ Pipeline completed successfully.'
        }
    }
}

