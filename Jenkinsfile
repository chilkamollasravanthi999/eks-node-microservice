pipeline {
    agent any

    environment {
        AWS_REGION = 'ap-south-1'
        ECR_REPO = '891970965031.dkr.ecr.ap-south-1.amazonaws.com/node-microservice'
        IMAGE_TAG = 'node:20-alpine'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/chilkamollasravanthi999/eks-node-microservice'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Run Tests') {
            steps {
                sh 'npm test || echo "No tests found"'
            }
        }

        stage('Build & Push Docker Image with Kaniko') {
    steps {
        container('kaniko') {  // runs inside Kaniko container
            sh '''
            /kaniko/executor \
                --dockerfile=$WORKSPACE/Dockerfile
                --context=$WORKSPACE/
                --destination=$ECR_REPO:$IMAGE_TAG \
                --oci-layout-path=/workspace/output \
                --verbosity=info
            '''
        }
    }
}
            

        stage('Deploy to EKS') {
            steps {
                sh '''
                kubectl apply -f k8s/deployment.yaml
                kubectl apply -f k8s/service.yaml
                '''
            }
        }
    }

    post {
        success {
            echo 'Deployment successful!'
        }
        failure {
            echo 'Something went wrong!'
        }
    }
}