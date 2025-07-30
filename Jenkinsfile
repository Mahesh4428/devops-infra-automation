pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

    stages {
        stage('Checkout SCM') {
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
                input message: "Do you want to apply Terraform changes?"
                sh 'terraform apply -auto-approve'
            }
        }

        stage('Ansible - Jenkins Setup') {
            steps {
                sh '''
                ansible-playbook -i ansible/inventory.ini \
                    --private-key ~/.ssh/newpem.pem \
                    ansible/jenkins_setup.yml
                '''
            }
        }

        stage('Ansible - K8s Setup') {
            steps {
                sh '''
                ansible-playbook -i ansible/inventory.ini \
                    --private-key ~/.ssh/newpem.pem \
                    ansible/k8s_setup.yml
                '''
            }
        }
    }

    post {
        success {
            echo 'Pipeline executed successfully!'
        }
        failure {
            echo 'Pipeline failed. Check the logs above.'
        }
    }
}

