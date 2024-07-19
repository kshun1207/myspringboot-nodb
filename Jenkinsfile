pipeline{
    agent none

    stages{
        stage('Checkout'){
            agent any
            steps{
                git branch: 'main', url: 'https://github.com/kshun1207/spring-example.git'
            }
        }
        stage('Build'){
            agent {
                docker { image 'gradle:jdk21' } 
            } 
            steps { 
                sh 'pwd'
                sh 'gradle build' 
            } 
        }
        /*stage('Test'){
            agent {
                docker { image 'maven:3-openjdk-17' } 
            } 
            steps { 
                sh 'mvn test' 
            } 
        }*/
        stage('Build Docker Image'){
            agent any
            steps{
                sh 'docker image build -t mytomcat .'
            }
        }
        stage('Tag Docker Image'){
            agent any
            steps{
                sh 'docker image tag mytomcat kshun1207/myspringboot:latest'
                //sh 'docker image tag mytomcat kshun1207/mytomcat:$BUILD_NUMBER'
            }
        }
        stage('Publish Docker Image'){
            agent any
            steps{
                withDockerRegistry(credentialsId: 'docker-hub-token', url: 'https://index.docker.io/v1/'){
                    sh 'docker image push kshun1207/myspringboot:latest'
                    //sh 'docker image push kshun1207/mytomcat:$BUILD_NUMBER'
                }
            }
        }
        stage('Run Docker Container'){
            agent {
                docker { image 'docker:dind'}
            }
            steps{
                sh 'docker -H tcp://192.168.56.104:2375 container run --detach --name mytomcat -p 80:8080 kshun1207/mytomcat:$BUILD_NUMBER'
            }
        }
    }
}