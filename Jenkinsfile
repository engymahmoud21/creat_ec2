pipeline {
    agent any

    parameters {
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
        choice(name: 'action', choices: ['apply', 'destroy'], description: 'Select the action to perform')
    }

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
        
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/engymahmoud21/creat_ec2.git'
            }
        }
        
        stage('Terraform init') {
            steps {
                script {
                    dir('creat_ec2') {
                        sh 'terraform init'
                    }
                }
            }
        }
        stage('Plan') {
            steps {
                script {
                    dir('creat_ec2') {
                        sh 'terraform plan -var="key_name=your-key-name" -out=tfplan'
                        sh 'terraform show -no-color tfplan > tfplan.txt'
                    }
                }
            }
        }
        stage('Apply / Destroy') {
            steps {
                script {
                    dir('creat_ec2') {
                        if (params.action == 'apply') {
                            if (!params.autoApprove) {
                                def plan = readFile 'tfplan.txt'
                                input message: "Do you want to apply the plan?",
                                parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                            }
                            sh 'terraform apply -input=false tfplan'
                        } else if (params.action == 'destroy') {
                            sh 'terraform destroy -auto-approve'
                        } else {
                            error "Invalid action selected. Please choose either 'apply' or 'destroy'."
                        }
                    }
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}

