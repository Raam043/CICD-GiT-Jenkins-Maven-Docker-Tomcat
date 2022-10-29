# Pull base image 
From tomcat:9-jre9

# Maintainer 
MAINTAINER "Ramesh NB" 

COPY ./webapp.war /usr/local/tomcat/webapps
