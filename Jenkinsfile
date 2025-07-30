pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
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
        stage('Ansible Playbook') {
            steps {
                sh 'ansible-playbook -i ansible/hosts.cfg ansible/jenkins.yml'
                sh 'ansible-playbook -i ansible/hosts.cfg ansible/k8s.yml'
            }
        }
    }
    post {
        failure {
            echo '🚨 Pipeline failed. Check the logs.'
        }
        success {
            echo '✅ Pipeline completed successfully!'
        }
    }
}
