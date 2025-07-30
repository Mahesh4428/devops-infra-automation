pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-creds')
        AWS_SECRET_ACCESS_KEY = credentials('aws-creds')
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Mahesh4428/devops-intern-assignment.git'
            }
        }

        stage('Terraform Init') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('terraform') {
                    sh 'terraform plan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('terraform') {
                    sh 'terraform apply -auto-approve'
                }
            }
        }

        stage('Ansible Setup') {
            steps {
                dir('ansible') {
                    script {
                        if (fileExists('inventory.ini')) {
                            sh 'ansible-playbook -i inventory.ini playbook.yml'
                        } else {
                            echo "⚠️ inventory.ini not found. Skipping Ansible stage."
                        }
                    }
                }
            }
        }
    }

    post {
        failure {
            echo "🚨 Pipeline failed. Check the logs."
        }
        success {
            echo "✅ Pipeline completed successfully."
        }
    }
}

