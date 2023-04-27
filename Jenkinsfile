pipeline{
  agent any
  
  environment{
	//def mvnHome = tool name: 'Maven-3.9.1', type: 'maven'
	//def mvnCMD = "${mvnHome}/bin/mvn "
  }
  
  stages{
  
    stage("Git Checkout"){
	  steps{
	    git branch: 'main', credentialsId: 'git-creds', url: 'https://github.com/akashtalla/demo-counter-app.git'
	  }
	}
	
    stage("Maven Unit Testing"){
	  steps{
	    sh "mvn test"
	  }
	}
	
    stage("Maven Integration Testing"){
	  steps{
	    sh "mvn verify -DskipUnitTests"
	  }
	}
	
    stage("Maven Build & Package"){
	  steps{
	    sh "mvn clean package"
	  }
	}
	
    stage("Create Docker Image"){
	  steps{
	    sh "docker build -t akashtalla/demo-counter-app:${BUILD_NUMBER} ."
	  }
	}
	
  }
  
}
