pipeline{
  agent any
  
  environment{
	    mvnHome = tool name: 'Maven-3.9.1', type: 'maven'
		jdkHome = tool name: 'jdk-17', type: 'jdk'
		mvnCMD = "${mvnHome}/bin/mvn"
		dockerTag = getDockerTag()
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
	
    stage("Deploy to K8s"){
	  steps{
	       bat "chmod +x changeTag.sh"
		   bat "./changeTag.sh ${dockerTag}"
		   sshagent(['mycred']) {
               sh 'scp -o StrictHostKeyChecking=no Deployment.yml service.yml LAPTOP-9VOD4K4E@172.24.192.1'
			   script{
			     try{
				   sh 'ssh LAPTOP-9VOD4K4E@172.24.192.1 kubectl apply -f .'
				 }
				 catch(error){
				   sh 'ssh "LAPTOP-9VOD4K4E@172.24.192.1 kubectl create -f .'
				 }
			   }
           }
	  }
	}	
  }
  
}

def getDockerTag(){
  def tag = bat script: 'git rev-parse HEAD', returnStdout: true
  return tag
}
