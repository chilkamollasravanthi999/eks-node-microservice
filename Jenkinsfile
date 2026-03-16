pipeline {
agent {
kubernetes {
yaml """
apiVersion: v1
kind: Pod
spec:
containers:

* name: node
  image: node:20
  command:

  * cat
    tty: true

* name: kaniko
  image: gcr.io/kaniko-project/executor:latest
  command:

  * /busybox/sleep
    args:
  * "999999"
    tty: true

* name: kubectl
  image: bitnami/kubectl:latest
  command:

  * cat
    tty: true
    """
    }
    }

environment {
AWS_REGION = 'ap-south-1'
ECR_REPO = '891970965031.dkr.ecr.ap-south-1.amazonaws.com/node-microservice'
IMAGE_TAG = 'latest'
}

stages {

```
stage('Checkout') {
  steps {
    git branch: 'master', url: 'https://github.com/chilkamollasravanthi999/eks-node-microservice'
  }
}

stage('NPM Build') {
  steps {
    container('node') {
      sh 'npm install'
      sh 'npm run build || echo "No build script found"'
    }
  }
}

stage('Run Tests') {
  steps {
    container('node') {
      sh 'npm test || echo "No tests found"'
    }
  }
}

stage('Build & Push Image (Kaniko)') {
  steps {
    container('kaniko') {
      sh '''
      /kaniko/executor \
        --dockerfile=$WORKSPACE/Dockerfile \
        --context=$WORKSPACE \
        --destination=$ECR_REPO:$IMAGE_TAG \
        --verbosity=info
      '''
    }
  }
}

stage('Deploy to EKS') {
  steps {
    container('kubectl') {
      sh '''
      kubectl apply -f k8s/deployment.yaml
      kubectl apply -f k8s/service.yaml
      '''
    }
  }
}
```

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
