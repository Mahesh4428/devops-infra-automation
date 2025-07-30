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
               ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory.ini playbooks/jenkins.yml
               ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory.ini playbooks/k8s.yml
            '''
        }
    }
}
