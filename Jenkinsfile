pipeline{
  agent any
  
  stages{
    stage("Git Checkout"){
	  git branch: 'main', credentialsId: 'git-creds', url: 'https://github.com/akashtalla/demo-counter-app.git'
	}
  }
}
