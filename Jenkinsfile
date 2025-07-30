pipeline {
  agent any

  environment {
    AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
    AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
  }

  stages {
    stage('Terraform Init & Apply') {
      steps {
        withCredentials([string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID'),
                         string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY')]) {
          dir('terraform') {
            sh 'rm -rf .terraform terraform.tfstate terraform.tfstate.backup .terraform.lock.hcl'
            sh 'terraform init -input=false'
            sh 'terraform apply -auto-approve'
          }
        }
      }
    }

    stage('Ansible Provision from Terraform Node') {
      steps {
        sh 'echo "Ansible goes here..."'
      }
    }
  }

  post {
    failure {
      echo '❌ Pipeline failed. Check the console logs for errors.'
    }
  }
}

