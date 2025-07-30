pipeline {
    agent any

    stages {
        stage('Terraform Init & Apply') {
            steps {
                withCredentials([
                    [$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-creds']
                ]) {
                    dir('terraform') {
                        sh '''
                            terraform init -input=false
                            terraform apply -auto-approve
                        '''
                    }
                }
            }
        }

        stage('Ansible Provision from Terraform Node') {
            steps {
                sh '''
                    ssh -o StrictHostKeyChecking=no -i /var/lib/jenkins/newpem.pem ubuntu@13.233.144.101 \
                    'cd /home/ubuntu/devops-project/ansible && \
                    ansible-playbook -i inventory.ini playbooks/jenkins.yml && \
                    ansible-playbook -i inventory.ini playbooks/k8s.yml'
                '''
            }
        }
    }

    post {
        failure {
            echo "❌ Pipeline failed. Check the console logs for errors."
        }
    }
}

