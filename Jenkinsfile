pipeline {
    agent any
    environment {
        DOCKER=credentials('docker')
        scannerHome = tool 'SonarQubeScanner'
    }
    stages {
        stage ('git checkout') {
            steps {
                cleanWs()
               git branch: 'main', url: 'https://github.com/hemanthkatkozu/demo-sonarcheck.git' 
            }
        }
        stage('SonarQube Analysis') {
            steps {
                script {
                withSonarQubeEnv('sonarqube') {
                sh """${scannerHome}/bin/sonar-scanner \
                -D sonar.projectVersion=1.0-SNAPSHOT \
                -D sonar.login=admin \
                -D sonar.password=admin \
                -D sonar.projectBaseDir=/root/.jenkins/workspace/sonar-test2 \
                -D sonar.projectKey=ABHI-AMU \
                -D sonar.sourceEncoding=UTF-8 \
                -D sonar.language=java \
                -D sonar.sources=src/main \
                -D sonar.tests=src/test \
                -D sonar.host.url=http://18.182.50.189:9000/"""
              }
           }
        }
      }
      stage ('maven-build') {
          steps {
              sh '''
              cd $WORKSPACE
              mvn clean package
              '''
          }
      }
      stage ('docker-build') {
          steps {
              sh '''
              docker login -u $DOCKER_USR -p $DOCKER_PSW
              docker build -t amu-first-test .
              docker tag amu-first-test:latest amukrishna05/amu-first-test:latest
              docker push amukrishna05/amu-first-test:latest
              docker rmi amu-first-test:latest
              '''
          }
      }
    }
    post {
        always {
            cleanWs()
        }
    }
}
