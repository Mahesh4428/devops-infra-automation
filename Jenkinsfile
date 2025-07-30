pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

    stages {

        stage('Terraform Init') {
            steps {
                echo '🔧 Initializing Terraform...'
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                echo '📝 Running Terraform Plan...'
                sh 'terraform plan'
            }
        }

        stage('Terraform Apply') {
            steps {
                echo '🚀 Applying Terraform Configuration...'
                sh 'terraform apply -auto-approve'
            }
        }

        stage('Ansible - Jenkins Setup') {
            steps {
                echo '🔧 Running Ansible for Jenkins setup...'
                dir('ansible') {
                    sh 'ansible-playbook -i hosts.cfg jenkins.yml || true'
                }
            }
        }

        stage('Ansible - Kubernetes Setup') {
            steps {
                echo '🔧 Running Ansible for Kubernetes setup...'
                dir('ansible') {
                    sh 'ansible-playbook -i hosts.cfg k8s.yml || true'
                }
            }
        }

    }

    post {
        success {
            echo '✅ Pipeline completed successfully.'
        }
        failure {
            echo '❌ Pipeline failed. Check logs.'
        }
    }
}

