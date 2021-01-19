def gv
pipeline {
 agent any
        parameters {
           choice choices: ['1.1.0', '1.2.0', '1.3.0'], description: '', name: 'VERSION'
           booleanParam defaultValue: true, description: '', name: 'executeTests'
                   }

    stages {
	  stage("init"){
	    steps {
		  script {
		       gv = load "script.groovy"
		  		 } 
		}
		
	  }
	  stage("build"){
	    steps {
		  script {
		       gv.buildApp()
		         }	  
		}
		
	  }
	  stage("test"){
	  when {
	       expression {
		      params.executeTests
		   }
	      }
	  steps {
	  gv.testApp()
	  }
	  }
	  stage("deploy"){
	    steps {
	    gv.deployApp()
		  
	     }
	  }
	}

}
