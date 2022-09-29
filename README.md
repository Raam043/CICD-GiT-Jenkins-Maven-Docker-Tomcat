>>>#!/bin/bash
>>>yum install docker -y
>>>service docker start

>>>useradd ramesh
>>>passwd ramesh      (add new pass ex.: ramesh123)

>>>usermod -aG docker ramesh
>>>mkdir /opt/docker


>>>vi Dockerfile
====================================================
===Enter below data onto file===

# Pull base image 
From tomcat:9-jre9 

# Maintainer
MAINTAINER "DEVOPS with Ramesh NB" 

# copy war file on to container 
COPY ./webapp.war /usr/local/tomcat/webapps


==============================================================
nano /etc/ssh/sshd_config

===Edit Password setting===
===remove "#" from pass yes===
===Add "#" pass no===

>>>service sshd restart
=========================================================
===Manage Jenkins --> Configure system --> Publish over SSH --> add Docker server and credentials==

ssh Server
 => Name = Docker
 => Host name = 172.31.23.90 (Private IPv4 addresses/ from eC2 )
 => Useername = ramesh ( docker user id / it was created while installing dcoker on ec2)
 
 click on advance then select password authentication
 => password = ramesh123 
=============================================================
Create Maven based project
************SCM***********
select git 
repo : https://github.com/Raam043/CICD-GiT-Maven-Jenkins-Docker.git
branch : main

***********Build Triggers***********
Use Poll SCM = * * * * *
or use github hook

*********Pre Steps**************
Send files or execute commands over SSH
Server name = Docker ( Drop down from jenkins setting)
Sourche file = webapp/target/*.war
Remove prefix = webapp/target/
Remote directory = //opt//docker
Exec command = 
docker stop docker_demo;
docker rm -f docker_demo;
docker image rm -f docker_demo;
cd /opt/docker;
docker build -t docker_demo .

--------------------------------
add one more SSH server
Server = Docker
Exec command = docker run -d --name docker_demo -p 8090:8080 docker_demo

*********BUILD*********************
Root POM = pom.xml
Goals and options = ""

=====================================================

*** in server setting write below command for sudo for image***
>>>chown -R ramesh:ramesh /opt/docker

Save and build now 

For result please open new tab paste "Docker_Public_IP>:8090/webapp"
