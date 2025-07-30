pipeline {
    agent any

    stages {
        stage('Terraform Init & Apply') {
            steps {
                withCredentials([
                    string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID'),
                    string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY')
                ]) {
                    dir('terraform') {
                        sh '''
                            echo "Initializing Terraform..."
                            terraform init

                            echo "Planning Terraform..."
                            terraform plan

                            echo "Applying Terraform..."
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
                        echo "Running Ansible..."
                        ansible-playbook -i inventory.ini playbooks/jenkins.yml
                    '''
                }
            }
        }
    }

    post {
        failure {
            echo "❌ Pipeline failed. Check the console logs for errors."
        }
        success {
            echo "✅ Pipeline completed successfully."
        }
    }
}

