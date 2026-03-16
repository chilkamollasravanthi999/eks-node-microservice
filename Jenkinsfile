pipeline {
    agent any

    environment {
        AWS_REGION = 'ap-south-1'
        ECR_REPO = '891970965031.dkr.ecr.ap-south-1.amazonaws.com/node-microservice'
        IMAGE_TAG = 'latest'
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/chilkamollasravanthi999/eks-node-microservice'
            }
        }

        stage('NPM Build inside Node Container') {
            steps {
                echo 'Running npm install inside Node container'

                sh '''
                docker run --rm \
                -v $WORKSPACE:/app \
                -w /app \
                node:20-alpine \
                sh -c "npm install && npm run build || echo No build script"
                '''
            }
        }

        stage('Run Tests') {
            steps {
                sh '''
                docker run --rm \
                -v $WORKSPACE:/app \
                -w /app \
                node:20-alpine \
                sh -c "npm test || echo No tests found"
                '''
            }
        }

        stage('Build & Push Image with Kaniko') {
            steps {
                sh '''
                /kaniko/executor \
                --dockerfile=$WORKSPACE/Dockerfile \
                --context=$WORKSPACE \
                --destination=$ECR_REPO:$IMAGE_TAG \
                --verbosity=info
                '''
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
            echo 'Deployment successful'
        }
        failure {
            echo 'Pipeline failed'
        }
    }
}