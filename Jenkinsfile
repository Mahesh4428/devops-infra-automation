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
                            terraform init
                            terraform apply -auto-approve
                        '''
                    }
                }
            }
        }

        stage('Ansible Provision') {
            steps {
                dir('ansible') {
                    sh '''
                        ansible-playbook -i inventory.ini playbooks/jenkins.yml
                        ansible-playbook -i inventory.ini playbooks/k8s.yml
                    '''
                }
            }
        }
    }

    post {
        failure {
            echo "❌ Pipeline failed. Check the console logs for errors."
        }
    }
}

