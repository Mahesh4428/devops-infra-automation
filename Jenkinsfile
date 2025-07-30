pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Mahesh4428/devops-infra-automation.git'
            }
        }

        stage('Terraform Init') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
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

        stage('Ansible Install Jenkins') {
            steps {
                dir('ansible') {
                    sh 'ansible-playbook -i inventory.ini playbooks/jenkins.yml'
                }
            }
        }

        stage('Ansible Install Kubernetes') {
            steps {
                dir('ansible') {
                    sh 'ansible-playbook -i inventory.ini playbooks/k8s.yml'
                }
            }
        }
    }

    post {
        failure {
            echo "❌ Pipeline failed. Check the console logs for errors."
        }
        success {
            echo "✅ Pipeline completed successfully!"
        }
    }
}

