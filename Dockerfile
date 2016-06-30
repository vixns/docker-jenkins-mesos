FROM vixns/mesos
MAINTAINER Stéphane Cottin <stephane.cottin@vixns.com>

ADD http://mirrors.jenkins-ci.org/war/2.11/jenkins.war /opt/jenkins.war
RUN chmod 644 /opt/jenkins.war
ENV JENKINS_HOME /var/lib/jenkins

ENTRYPOINT ["java", "-jar", "/opt/jenkins.war"]
EXPOSE 8080
