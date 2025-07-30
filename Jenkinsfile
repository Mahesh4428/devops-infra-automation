pipeline {
    agent any

    environment {
        // Optional: Set AWS Region if you use it often
        AWS_DEFAULT_REGION = 'ap-south-1'
    }

    stages {
        stage('Terraform Init & Apply') {
            steps {
                withCredentials([
                    [$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-creds']
                ]) {
                    dir('terraform') {
                        sh '''
                            terraform init
                            terraform apply -auto-approve
                        '''
                    }
                }
            }
        }

        stage('Ansible Provision from Terraform Node') {
            steps {
                sh '''
                    ssh -o StrictHostKeyChecking=no -i /var/lib/jenkins/newpem.pem ubuntu@13.233.144.101 '
                        cd /home/ubuntu/devops-project/ansible &&
                        ansible-playbook -i inventory.ini playbooks/jenkins.yml &&
                        ansible-playbook -i inventory.ini playbooks/k8s.yml
                    '
                '''
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline completed successfully!'
        }
        failure {
            echo '❌ Pipeline failed. Check the console logs for errors.'
        }
    }
}

