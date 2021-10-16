# openehr
OpenEHR Docker &amp; Kubernetes

#Instructions
 Installation instructions: Require Docker
  Download the two files
  1.Dockerfile
  2.run.sh
  
#Build
 docker build -t openehr/demo .

#Run
 docker run -d -p 8090:8090 openehr/demo
 
#Access

 open browser and login to http://localhost:8090
