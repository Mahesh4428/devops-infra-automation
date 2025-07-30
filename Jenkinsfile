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

        stage('Ansible Playbook') {
            steps {
                // Optional: Only change this if ansible folder exists
                dir('ansible') {
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
