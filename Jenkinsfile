pipeline {
    agent any

    environment {
        TF_IN_AUTOMATION = "true"
    }

    stages {
        stage('Checkout SCM') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/Mahesh4428/devops-infra-automation.git'
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
                script {
                    if (fileExists('ansible/jenkins.yml')) {
                        sh 'ansible-playbook -i ansible/hosts.cfg ansible/jenkins.yml'
                    } else {
                        error "Playbook ansible/jenkins.yml not found!"
                    }
                }
            }
        }

        stage('Ansible - K8s Setup') {
            steps {
                script {
                    if (fileExists('ansible/k8s.yml')) {
                        sh 'ansible-playbook -i ansible/hosts.cfg ansible/k8s.yml'
                    } else {
                        error "Playbook ansible/k8s.yml not found!"
                    }
                }
            }
        }
    }

    post {
        failure {
            echo "Pipeline failed. Check logs above."
        }
        success {
            echo "Pipeline completed successfully."
        }
    }
}

