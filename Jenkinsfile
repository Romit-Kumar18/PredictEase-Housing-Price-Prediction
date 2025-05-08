def IMAGES = [
  [name: 'romitkumar18/predictease-housing-price-prediction-backend', dir: 'backend'],
  [name: 'romitkumar18/predictease-housing-price-prediction-frontend', dir: 'frontend'],
  [name: 'romitkumar18/predictease-housing-price-prediction-ml-service', dir: 'ml-service'],
  [name: 'romitkumar18/predictease-housing-price-prediction-nginx', dir: 'nginx']
]

pipeline {
  agent any

  environment {
    DOCKER_CREDS = credentials('dockerhub-creds')
    AWS_CREDS   = credentials('aws-creds')
    TF_WORKING_DIR = 'terraform'
  }

  stages {
    stage('Init') {
      steps {
        withEnv(["DOCKER_HOST=tcp://host.docker.internal:2375"]) {
          sh 'echo $DOCKER_CREDS_PSW | docker login -u $DOCKER_CREDS_USR --password-stdin'
        }
      }
    }

    stage('Inspect Workspace') {
      steps {
        sh 'pwd && ls -R .'
      }
    }

    stage('Build & Push Images') {
      steps {
        script {
          def branches = IMAGES.collectEntries { img ->
            [ (img.name) : {
                stage("Build-Push ${img.name}") {
                  dir(img.dir) {
                    sh "docker build -t ${img.name}:$BUILD_NUMBER ."
                    sh "docker push ${img.name}:$BUILD_NUMBER"
                  }
                }
              }
            ]
          }
          parallel branches
        }
      }
    }

    stage('Terraform Init') {
      steps {
        withEnv([
          "AWS_ACCESS_KEY_ID=${env.AWS_CREDS_USR}",
          "AWS_SECRET_ACCESS_KEY=${env.AWS_CREDS_PSW}"
        ]) {
          dir(env.TF_WORKING_DIR) {
            sh 'terraform init -backend-config="bucket=my-tfstate-bucket" -backend-config="region=us-east-1"'
          }
        }
      }
    }

    stage('Terraform Plan') {
      steps {
        withEnv([
          "AWS_ACCESS_KEY_ID=${env.AWS_CREDS_USR}",
          "AWS_SECRET_ACCESS_KEY=${env.AWS_CREDS_PSW}"
        ]) {
          dir(env.TF_WORKING_DIR) {
            sh 'terraform plan -out=tfplan'
          }
        }
      }
    }

    stage('Terraform Apply') {
      steps {
        withEnv([
          "AWS_ACCESS_KEY_ID=${env.AWS_CREDS_USR}",
          "AWS_SECRET_ACCESS_KEY=${env.AWS_CREDS_PSW}"
        ]) {
          dir(env.TF_WORKING_DIR) {
            sh 'terraform apply -auto-approve tfplan'
          }
        }
      }
    }


    stage('Cleanup') {
      steps {
        echo 'Removing local images…'
        script {
          IMAGES.each { img ->
            sh "docker rmi ${img.name}:$BUILD_NUMBER || true"
          }
        }
      }
    }
  }

  post {
    always {
      sh 'docker logout'
      echo 'Cleaning up Terraform workflow…'
      dir(env.TF_WORKING_DIR) {
        sh 'rm -f tfplan'
      }
    }
  }
}