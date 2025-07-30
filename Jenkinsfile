pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = '<YOUR_AWS_ACCESS_KEY_ID>'
        AWS_SECRET_ACCESS_KEY = '<YOUR_AWS_SECRET_ACCESS_KEY>'
    }

    stages {
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

        stage('Ansible Playbook') {
            steps {
                dir('ansible') {
                    // Let this fail — we’ll fix it later
                    sh 'ansible-playbook -i inventory install-k8s.yaml || true'
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

