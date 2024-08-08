pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID = credentials('aws-access-key-id') // استخدم معرف بيانات الاعتماد الصحيح
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key') // استخدم معرف بيانات الاعتماد الصحيح
    }

    stages {
        stage('Clone Repository') {
            steps {
                git url: 'https://github.com/engymahmoud21/creat_ec2.git', branch: 'main'
            }
        }

        stage('Install Terraform') {
            steps {
                sh '''
                    curl -o terraform.zip https://releases.hashicorp.com/terraform/1.5.3/terraform_1.5.3_linux_amd64.zip
                    unzip terraform.zip
                    sudo mv terraform /usr/local/bin/
                    terraform -v
                '''
            }
        }

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

       
        }
    }

    post {
        always {
            cleanWs()
        }
        success {
            echo 'Pipeline completed successfully.'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
