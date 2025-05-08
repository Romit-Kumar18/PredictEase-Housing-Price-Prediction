pipeline {
  agent any
  environment {
    DOCKER_CREDS = credentials('dockerhub-creds')
    IMAGES = [
      [name: 'romitkumar18/predictease-housing-price-prediction-backend', dir: 'predictease-housing-price-prediction-backend'],
      [name: 'romitkumar18/predictease-housing-price-prediction-frontend', dir: 'predictease-housing-price-prediction-frontend'],
      [name: 'romitkumar18/predictease-housing-price-prediction-ml-service', dir: 'predictease-housing-price-prediction-ml-service'],
      [name: 'romitkumar18/predictease-housing-price-prediction-nginx', dir: 'predictease-housing-price-prediction-nginx']
    ]
  }
  stages {
    stage('Init') {
      steps {
        echo "Logging into Docker Hub as ${env.DOCKER_CREDS_USR}"
        sh 'echo $DOCKER_CREDS_PSW | docker login -u $DOCKER_CREDS_USR --password-stdin'
      }
    }
    stage('Build & Push Images') {
      parallel {
        script {
          IMAGES.collectEntries { img ->
            [ (img.name): {
                stage("Build-Push ${img.name}") {
                  dir(img.dir) {
                    sh "docker build -t ${env.DOCKER_CREDS_USR}/${img.name}:$BUILD_NUMBER ."
                    sh "docker push ${env.DOCKER_CREDS_USR}/${img.name}:$BUILD_NUMBER"
                  }
                }
            }]
          }
        }
      }
    }
    stage('Cleanup') {
      steps {
        echo 'Removing local images…'
        script {
          IMAGES.each { img ->
            sh "docker rmi ${env.DOCKER_CREDS_USR}/${img.name}:$BUILD_NUMBER || true"
          }
        }
      }
    }
  }
  post {
    always { sh 'docker logout' }
  }
}
