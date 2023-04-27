pipeline{
  agent any
  
  environment{
	    mvnHome = tool name: 'Maven-3.9.1', type: 'maven'
		jdkHome = tool name: 'jdk-17', type: 'jdk'
		mvnBin = "C:/ProgramData/Jenkins/.jenkins/tools/hudson.tasks.Maven_MavenInstallation/Maven-3.9.1/bin/mvn"
		mvnCMD = "${mvnHome}/bin/mvn"
  }
  
  tools{
        maven 'Maven-3.9.1'
	    jdk 'jdk-17'
  }
  
  stages{
  
    stage("Git Checkout"){
	  steps{
	    git branch: 'main', credentialsId: 'git-creds', url: 'https://github.com/akashtalla/demo-counter-app.git'
	  }
	}
	
    stage("Maven Unit Testing"){
	  steps{
	    bat "${mvnCMD} test"
	  }
	}
	
    stage("Maven Integration Testing"){
	  steps{
	    bat "${mvnCMD} verify -DskipUnitTests"
	  }
	}
	
    stage("Maven Build & Package"){
	  steps{
	    bat "${mvnCMD} clean package"
	  }
	}
	
    stage("Create Docker Image"){
	  steps{
	    bat "docker build -t akashtalla/demo-counter-app:v1.${BUILD_ID} ."
	    bat "docker build -t akashtalla/demo-counter-app:latest ."
	  }
	}
	
    stage("Docker Image Push"){
	  steps{
          withCredentials([string(credentialsId: 'dockerPass', variable: 'dockerPass')]) {
            bat "docker login -u akashtalla -p ${dockerPass}"
          }	    
	    bat "docker push akashtalla/demo-counter-app:v1.${BUILD_ID}"
	    bat "docker push akashtalla/demo-counter-app:latest"
	  }
	}
	
  }
  
}
