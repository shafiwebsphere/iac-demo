def buildAPP(){
   echo 'building the application....'
}
def testApp(){
  echo 'testing the application.....'
}
def deployApp(){
  echo 'deploying the application.....'
  echo "deploying the application ${params.VERSION}"
}
return this